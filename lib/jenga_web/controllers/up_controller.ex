defmodule JengaWeb.UpController do
  use JengaWeb, :controller

  def up(conn, _params) do
    {code, message} = status()
    conn
    |> Plug.Conn.put_status(code)
    |> json(message)
  end

  defp status do
    case Jenga.Database.check_status() do
      :ok ->
        {200, %{status: "OK"}}

      _ ->
        {500, %{status: "LOADING"}}
    end
  end
end

