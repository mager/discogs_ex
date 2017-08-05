defmodule DiscogsEx.ClientTest do
  use ExUnit.Case
  import DiscogsEx.Client

  doctest DiscogsEx.Client

  test "default endpoint" do
    client = new(%{})
    assert client.endpoint == "https://api.discogs.com/"
  end

  test "custom endpoint" do
    expected = "https://discogs.xyz/"

    client = new(%{}, "https://discogs.xyz/")
    assert client.endpoint == expected
  end

  test "trailing slash" do
    expected = "https://discogs.xyz/"

    client = new(%{}, "https://discogs.xyz")
    assert client.endpoint == expected
  end
end
