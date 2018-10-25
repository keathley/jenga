defmodule Jenga.Database.Watchdog do
  use GenServer

  @alarm_id :database_disconnected

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    schedule_check()
    {:ok, %{status: :degraded, passing_checks: 0}}
  end

  def handle_info(:check_db, state) do
    status = Jenga.Database.check_status()
    state = change_state(status, state)
    schedule_check()

    {:noreply, state}
  end

  defp change_state(result, %{status: status, passing_checks: count}) do
    case {result, status, count} do
      {:ok, :connected, count} ->
        if count == 3 do
          :alarm_handler.clear_alarm(@alarm_id)
        end
        %{status: :connected, passing_checks: count + 1}

      {:ok, :degraded, _} ->
        %{status: :connected, passing_checks: 0}

      {:error, :connected, _} ->
        :alarm_handler.set_alarm({@alarm_id, "We cannot connect to the databas"})
        %{status: :degraded, passing_checks: 0}

      {:error, :degraded, _} ->
        %{status: :degraded, passing_checks: 0}
    end
  end

  defp schedule_check do
    Process.send_after(self(), :check_db, 1000)
  end
end
