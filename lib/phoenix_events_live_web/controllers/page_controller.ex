defmodule PhoenixEventsLiveWeb.PageController do
  use PhoenixEventsLiveWeb, :controller

  def index(conn, _params) do
    html(conn, File.read!("priv/static/index.html"))
    # render(conn, "index.html")
  end
end
