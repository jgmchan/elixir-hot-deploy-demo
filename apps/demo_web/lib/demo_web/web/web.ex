defmodule DemoWeb.Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: DemoWeb.Web
      import Plug.Conn
      import DemoWeb.Web.Router.Helpers
      import DemoWeb.Web.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/demo_web/web/templates",
                        namespace: DemoWeb.Web

      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      use Phoenix.HTML

      import DemoWeb.Web.Router.Helpers
      import DemoWeb.Web.ErrorHelpers
      import DemoWeb.Web.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import DemoWeb.Web.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
