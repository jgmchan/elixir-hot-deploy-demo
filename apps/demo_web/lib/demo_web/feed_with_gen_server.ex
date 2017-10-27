defmodule DemoWeb.FeedWithGenServer do
  @moduledoc """
  Does the same thing as DemoWeb.Feed but it uses a Genserver to track
  state. This shows how during a hot upgrade, the state is kept
  instead of being blown away.
  """
  use GenServer

  @topic "room:feed_gen"

  def start_link() do
    GenServer.start_link(__MODULE__, %{count: 0})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    new_count = state.count + 1

    DemoWeb.Web.Endpoint.broadcast(
      @topic,
      "FEED_GEN",
      %{timestamp: DateTime.utc_now,
        pid: inspect(self()),
        count: new_count}
    )

    schedule_work()

    {:noreply, %{count: new_count}}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 1000)
  end
end

