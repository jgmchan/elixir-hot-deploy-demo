defmodule DemoWeb.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(DemoWeb.Web.Endpoint, []),
      worker(DemoWeb.Feed, []),
      worker(DemoWeb.FeedWithGenServer, [])
    ]

    opts = [strategy: :one_for_one, name: DemoWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
