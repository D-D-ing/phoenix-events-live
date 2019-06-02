defmodule PhoenixEventsLiveWeb.UserView do
  use PhoenixEventsLiveWeb, :view

  def render("user.json", %{user: user}) do
    %{status: "ok",
      user: %{id: user.id,
              username: user.username,
              token: user.token,
              name: user.name,
              email: user.email}
    }
  end

  def render("jwt.json", %{jwt: jwt, user: user}) do
    %{status: "ok",
      message: "User logged in.",
      user: %{
        username: user.username,
        name: user.name
      },
      token: jwt}
  end
end
