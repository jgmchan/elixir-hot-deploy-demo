use Mix.Config

config :demo_web,
  namespace: DemoWeb,
  ecto_repos: [DemoWeb.Repo]

config :demo_web, DemoWeb.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2vKUeGuughyjm4KgOTowKcVxfnhNriaiP/vKt+BLO3NLY2C15FDEk8d2adBm3VtN",
  render_errors: [view: DemoWeb.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DemoWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
