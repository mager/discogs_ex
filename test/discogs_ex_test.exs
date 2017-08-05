defmodule DiscogsEx.DiscogsExTest do
  use ExUnit.Case
  import DiscogsEx

  doctest DiscogsEx

  setup_all do
    :meck.new(JSX, [:no_link])

    on_exit fn ->
      :meck.unload JSX
    end
  end

  test "authorization_header/1" do
    expected = [{"Authorization", "Discogs key=key, secret=secret"}]

    assert authorization_header(%{key: "key", secret: "secret"}) == expected
  end

  describe "process_response/1" do
    test "200" do
      expected = "response"
      assert process_response(%HTTPoison.Response{
        status_code: 200,
        headers: %{},
        body: "response"
      }) == expected
    end

    test "404" do
      expected = {404, "response"}
      assert process_response(%HTTPoison.Response{
        status_code: 404,
        headers: %{},
        body: "response"
      }) == expected
    end
  end

  describe "process_response_body" do
    test "with content" do
      :meck.expect(JSX, :decode!, 1, :decoded_json)
      assert process_response_body("json") == :decoded_json
    end
  end
end
