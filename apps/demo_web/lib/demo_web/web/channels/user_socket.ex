defmodule DemoWeb.Web.UserSocket do
  use Phoenix.Socket

  channel "room:*", DemoWeb.Web.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
