defmodule DiscogsEx.DatabaseTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import DiscogsEx.Database

  doctest DiscogsEx.Database

  @client DiscogsEx.Client.new %{key: "key", secret: "secret"}

  setup_all do
    HTTPoison.start
  end

  describe "search/1" do
    test "success" do
      use_cassette "database#search" do
        response = search "Demi Lovato", %{"title": "sorry not sorry"}, @client
        assert Map.get(response, "pagination") == %{
          "items" => 3, "page" => 1, "pages" => 1, "per_page" => 50, "urls" => %{}
        }

        assert is_list(Map.get(response, "results"))

        first = Map.get(response, "results") |> Enum.at(0)
        assert first == %{
          "barcode" => ["1256232718"],
          "catno" => "none",
          "community" => %{
            "have" => 2,
            "want" => 0,
          },
          "country" => "Unknown",
          "format" => [
            "File", "AAC", "Single"
          ],
          "genre" => ["Pop"],
          "id" => 10559613,
          "label" => [
            "Hollywood Records", "Island Records", "Safehouse Records", "Hollywood Records, Inc."
          ],
          "resource_url" => "https://api.discogs.com/releases/10559613",
          "style" => ["Vocal"],
          "thumb" => "https://api-img.discogs.com/F2I6nvCRGxZUoJuws-ouhonFfIA=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/R-10559613-1499887916-1414.jpeg.jpg",
          "title" => "Demi Lovato - Sorry Not Sorry",
          "type" => "release",
          "uri" => "/Demi-Lovato-Sorry-Not-Sorry/release/10559613",
          "year" => "2017"
        }
      end
    end
  end
end
