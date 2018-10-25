defmodule JengaWeb.PageController do
  use JengaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
