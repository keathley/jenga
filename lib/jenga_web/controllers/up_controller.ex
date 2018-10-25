defmodule JengaWeb.UpController do
  use JengaWeb, :controller

  def up(conn, _params) do
    {code, message} = status()
    conn
    |> Plug.Conn.put_status(code)
    |> json(message)
  end

  defp status do
    {500, %{status: "LOADING"}}
  end
end
