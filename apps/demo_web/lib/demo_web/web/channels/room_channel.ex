defmodule DemoWeb.Web.RoomChannel do
  use Phoenix.Channel

  def join("room:" <> room, message, socket) do
    reply = %{body: "Welcome to the #{String.capitalize(room)} channel",
              session: :rand.uniform(10)}
    {:ok, reply, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

end
