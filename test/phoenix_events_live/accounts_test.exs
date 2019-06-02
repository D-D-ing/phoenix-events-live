defmodule PhoenixEventsLive.AccountsTest do
  use PhoenixEventsLive.DataCase

  alias PhoenixEventsLive.Accounts

  describe "users" do
    alias PhoenixEventsLive.Accounts.User

    @valid_attrs %{
      email: "some email",
      name: "some name",
      password_hash: "some password_hash",
      token: "some token",
      username: "some username"}

    @update_attrs %{email: "some updated email",
      name: "some updated name",
      password_hash: "some updated password_hash",
      token: "some updated token",
      username: "some updated username"}
    @invalid_attrs %{email: nil, name: nil, password_hash: nil, token: nil, username: nil}

    @pw_valid_attrs %{username: "some username", password: "some_password", password_confirmation: "some_password"}
    @pw_short_pw %{username: "some username", password: "short", password_confirmation: "short"}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    def user_with_password_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_with_password()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.token == "some token"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "create_user_with_password/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user_with_password(@pw_valid_attrs)
      assert user.username == "some username"
    end

    test "jwt_sign_in_with_password/2 with correct credentials returns token" do
      user_with_password_fixture(@pw_valid_attrs)
      assert {:ok, _, _} = Accounts.jwt_sign_in_with_password(@pw_valid_attrs.username, @pw_valid_attrs.password)
    end

    test "jwt_sign_in_with_password/2 with incorrent password returns error" do
      user_with_password_fixture(@pw_valid_attrs)
      assert {:error, _} = Accounts.jwt_sign_in_with_password(@pw_valid_attrs.username, "invalid password")
    end

    test "create_user_with_password/1 with too short password returns error" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_with_password(@pw_short_pw)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.token == "some updated token"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
