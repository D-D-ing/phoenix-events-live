# PhoenixEventsLive

To start the app:

  * Install dependencies with `mix deps.get`
  * Start your postgres db (for port and password see config/dev.exs)
    * You can start a postgres db in a docker container with `./startup_db`
    * Create and migrate your database with `mix ecto.setup`
  * Copy generated nuxt app (content of `dist` after running `npm run generate`) to priv/static
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

A development graphql server (graphiql) is running at http://localhost:4000/api/graphql/dev.
