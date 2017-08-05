defmodule DiscogsEx do
  use HTTPoison.Base
  alias DiscogsEx.Client

  @type response :: {integer, any} | :jsx.json_term

  def get_user_agent() do
    {:ok, version} = :application.get_key(:discogs_ex, :vsn)
    [{"User-agent", "DiscogsExClient/#{version}"}]
  end

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil
  def process_response_body(body), do: JSX.decode!(body)

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
  def process_response(%HTTPoison.Response{status_code: status_code, body: body}), do: { status_code, body }

  @spec url(client :: Client.t, path :: binary) :: binary
  def url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, headers, options)
    |> process_response
  end

  def request(method, url, auth, body \\ "") do
    json_request(method, url, body, get_header(auth))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    raw_request(method, url, JSX.encode!(body), headers, options)
  end

  @doc """
  GET request to the Discogs API.
  """
  def get(path, client, params \\ []) do
    url =
      client
      |> url(path)
      |> add_params_to_url(params)

    :get |> request(url, client.auth)
  end

  def delete(path, client, body \\ "") do
    request(:delete, url(client, path), client.auth, body)
  end

  def post(path, client, params, body \\ "") do
    url =
      client
      |> url(path)
      |> add_params_to_url(params)

    :post |> request(url, client.auth, body)
  end

  def patch(path, client, body \\ "") do
    request(:patch, url(client, path), client.auth, body)
  end

  def put(path, client, body \\ "") do
    request(:put, url(client, path), client.auth, body)
  end

  @doc """
  The Discogs API uses a key and secret for authentication.
  ## Examples
      iex> DiscogsEx.authorization_header(%{key: "key", secret: "secret"})
      [{"Authorization", "Discogs key=key, secret=secret"}]
  """
  @spec authorization_header(Client.auth) :: list
  def authorization_header(%{key: key, secret: secret}) do
    [{"Authorization", "Discogs key=#{key}, secret=#{secret}"}]
  end

  def get_header(auth) do
    get_user_agent() ++ authorization_header(auth)
  end

  @doc """
  Take an existing URI and add addition params, appending and replacing as necessary
  ## Examples
      iex> add_params_to_url("http://example.com/wat", [])
      "http://example.com/wat"
      iex> add_params_to_url("http://example.com/wat", [q: 1])
      "http://example.com/wat?q=1"
      iex> add_params_to_url("http://example.com/wat", [q: 1, t: 2])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat", %{q: 1, t: 2})
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&t=2", [])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1", [t: 2])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1", [q: 3, t: 2])
      "http://example.com/wat?q=3&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2])
      "http://example.com/wat?q=3&s=4&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&s=4", %{q: 3, t: 2})
      "http://example.com/wat?q=3&s=4&t=2"
  """
  @spec add_params_to_url(binary, list) :: binary
  def add_params_to_url(url, params) do
    url
    |> URI.parse
    |> merge_uri_params(params)
    |> String.Chars.to_string
  end

  @spec merge_uri_params(URI.t, list) :: URI.t
  def merge_uri_params(uri, []), do: uri
  def merge_uri_params(%URI{query: nil} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.put(:query, URI.encode_query(params))
  end
  def merge_uri_params(%URI{} = uri, params) when is_list(params) or is_map(params) do
    uri
    |> Map.update!(:query, fn q -> q |> URI.decode_query |> Map.merge(param_list_to_map_with_string_keys(params)) |> URI.encode_query end)
  end

  @spec param_list_to_map_with_string_keys(list) :: map
  def param_list_to_map_with_string_keys(list) when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new do
      {"#{key}", value}
    end
  end
end
