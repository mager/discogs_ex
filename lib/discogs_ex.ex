defmodule DiscogsEx do
  use HTTPoison.Base

  alias DiscogsEx.Client

  def get_user_agent() do
    {:ok, version} = :application.get_key(:discogs_ex, :vsn)
    [{"User-agent", "DiscogsExClient/#{version}"}]
  end
end
