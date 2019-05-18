defmodule PhoenixEventsLiveWeb.PageController do
  use PhoenixEventsLiveWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
