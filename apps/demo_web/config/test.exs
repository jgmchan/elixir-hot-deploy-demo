use Mix.Config

config :demo_web, DemoWeb.Web.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
