defmodule Jenga.Database do
  # use GenServer

  def check_status do
    case Ecto.Adapters.SQL.query(Jenga.Repo, "SELECT 1") do
      {:ok, _} ->
        :ok

      _ ->
        :error
    end
  end
end
