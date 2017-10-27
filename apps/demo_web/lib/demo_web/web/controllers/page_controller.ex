defmodule DemoWeb.Web.PageController do
  use DemoWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
