# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :discogs_ex, DiscogsExWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TqPH2UaS+O39B8VDq9mDHI5YVi2hdqL+q+Qy1c9lBkfmAZtw8R8fdSZQRhzGh3Zi",
  render_errors: [view: DiscogsExWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DiscogsEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
