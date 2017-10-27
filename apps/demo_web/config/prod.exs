use Mix.Config

config :demo_web, DemoWeb.Web.Endpoint,
  load_from_system_env: true,
  url: [host: "localhost", port: 80],
  # This setting tells the Endpoint to start Cowboy on start
  server: true,
  # This setting configures the root for static files
  root: "."

config :logger, level: :info

import_config "prod.secret.exs"
