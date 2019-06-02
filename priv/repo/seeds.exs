# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixEventsLive.Repo.insert!(%PhoenixEventsLive.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
test_user_attrs = %{
    username: "testuser",
    password: "testtest",
    password_confirmation: "testtest",
    name: "Torsten Tester",
    token: "jfff4j30jf4nuihnf7o343jmfjpf"
}

user_changeset = PhoenixEventsLive.Accounts.User.registration_changeset(%PhoenixEventsLive.Accounts.User{}, test_user_attrs)
PhoenixEventsLive.Repo.insert!(user_changeset)
