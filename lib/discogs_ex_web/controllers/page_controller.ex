defmodule DiscogsExWeb.PageController do
  use DiscogsExWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
