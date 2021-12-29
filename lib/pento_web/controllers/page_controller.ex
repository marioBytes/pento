defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    if is_nil(conn.assigns.current_user) do
      render(conn, "index.html")
    else
      redirect(conn, to: "/guess")
    end
  end
end
