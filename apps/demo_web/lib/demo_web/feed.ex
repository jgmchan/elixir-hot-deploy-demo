defmodule DemoWeb.Feed do
  @moduledoc """
  This module just increases a counter and broadcasts it periodically
  to a topic
  """
  @topic "room:feed"

  def start_link() do
    pid = spawn_link(__MODULE__, :init, [])
    {:ok, pid}
  end

  def init() do
    output(@topic)
  end

  @doc """
  Spits out the current time and an increasing count
  """
  def output(topic, count \\ 0) do
    DemoWeb.Web.Endpoint.broadcast(
      topic,
      "FEED",
      %{timestamp: DateTime.utc_now(), pid: inspect(self()), count: count}
    )

    :timer.sleep(1 * 1000)
    output(topic, count + 1)
  end
end
