defmodule PhoenixEventsLiveWeb.UserView do
  use PhoenixEventsLiveWeb, :view
  alias PhoenixEventsLiveWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      password_hash: user.password_hash,
      token: user.token,
      name: user.name,
      email: user.email}
  end
end
