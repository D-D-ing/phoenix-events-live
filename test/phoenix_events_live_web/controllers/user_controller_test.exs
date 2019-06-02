defmodule PhoenixEventsLiveWeb.UserControllerTest do
  use PhoenixEventsLiveWeb.ConnCase

  alias PhoenixEventsLive.Accounts

  @valid_attrs %{
    username: "some username",
    password: "some password",
    password_confirmation: "some password",
    name: "some name"
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user_with_password(@valid_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "sign_in" do
    setup [:create_user]

    test "signs valid user in", %{conn: conn} do
      conn = post(conn, "/api/rest/sign_in_with_password", %{username: @valid_attrs.username,
                                                            password: @valid_attrs.password})
      response = json_response(conn, 200)
      assert response["status"] == "ok"
      assert byte_size(response["message"]) > 0
      assert response["user"] == %{"username" => @valid_attrs.username, "name" => @valid_attrs.name}
      assert byte_size(response["token"]) > 0
    end

    test "do not sign in with incorrect password", %{conn: conn} do
      conn = post(conn, "/api/rest/sign_in_with_password", %{username: @valid_attrs.username,
                                                            password: "invalid_password"})
      response = json_response(conn, 401)
      assert response["status"] == "error"
      assert byte_size(response["message"]) > 0
      refute response["token"]
    end

    test "do not sign in invalid user", %{conn: conn} do
      conn = post(conn, "/api/rest/sign_in_with_password", %{username: "invalid_user",
                                                            password: "some_password"})
      response = json_response(conn, 401)
      assert response["status"] == "error"
      assert byte_size(response["message"]) > 0
      refute response["token"]
    end
  end

  describe "my_user" do
    setup [:create_user]

    test "my_user for logged in user return user profile", %{conn: conn} do
      signin_conn = post(conn, "/api/rest/sign_in_with_password", %{username: @valid_attrs.username,
                                                                    password: @valid_attrs.password})
      token = json_response(signin_conn, 200)["token"]

      conn = conn
      |> put_req_header("authorization", "Bearer " <> token)
      |> get("/api/rest/my_user")

      response = json_response(conn, 200)

      assert response["status"] == "ok"
      assert response["user"]["username"] == @valid_attrs.username
    end

    test "my_user for logged out user gives error", %{conn: conn} do
      conn = get(conn, "/api/rest/my_user")
      response = json_response(conn, 401)
      assert response["status"] == "error"
      assert byte_size(response["message"]) > 0
      refute response["token"]
    end
  end
end