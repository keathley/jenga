# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jenga,
  ecto_repos: [Jenga.Repo]

# Configures the endpoint
config :jenga, JengaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MbXWvH95KUonDUjgOLCX896LqXHSglY4adqmdqnuc2Y4/5aQovlQ6Gy7Ehvw0XdE",
  render_errors: [view: JengaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jenga.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
