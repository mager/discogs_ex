# DiscogsEx

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `discogs_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:discogs_ex, "~> 0.1.0"}]
end
```

## Usage

Create a client with your key and secret.

```elixir
iex> auth = %{key: "key", secret: "secret"}
iex> client = DiscogsEx.Client.new auth
%DiscogsEx.Client{auth: %{key: "key", secret: "secret"}, endpoint: "https://api.discogs.com/"}
iex> DiscogsEx.Database.search "Demi Lovato", %{"title": "sorry not sorry"}, client
%{
  "pagination" => %{
    "items" => 3, "page" => 1, "pages" => 1, "per_page" => 50, "urls" => %{}
  },
  "results" => [
    %{
      "barcode" => ["1256232718"],
      "catno" => "none",
      "community" => %{
        "have" => 2,
        "want" => 0
      },
      "country" => "Unknown",
      "format" => ["File", "AAC", "Single"],
      "genre" => ["Pop"],
      "id" => 10559613,
      "label" => ["Hollywood Records", "Island Records", "Safehouse Records", "Hollywood Records, Inc."],
      "resource_url" => "https://api.discogs.com/releases/10559613",
      "style" => ["Vocal"],
      "thumb" =>  "https://api-img.discogs.com/F2I6nvCRGxZUoJuws-ouhonFfIA=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-10559613-1499887916-1414.jpeg.jpg",
      "title" => "Demi Lovato - Sorry Not Sorry",
      "type" => "release",
      "uri" => "/Demi-Lovato-Sorry-Not-Sorry/release/10559613",
      "year" => "2017"},
    },
    # More results
  ]
}
```


## Documentation

```sh
mix docs
```

Once published, the docs can be found at [https://hexdocs.pm/discogs_ex](https://hexdocs.pm/discogs_ex).

## Testing

```sh
mix coveralls
```

## Version History

* 2017-08-05: *v0.0.1* - Initial release
  * DiscogsEx.Client
  * DiscogsEx.Database.Search
