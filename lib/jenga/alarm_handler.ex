defmodule Jenga.AlarmHandler do
  require Logger

  def init({:ok, {:alarm_handler, _old_alarms}}) do
    Logger.info("Installing alarm handler")
    {:ok, %{}}
  end

  def handle_event({:set_alarm, :database_disconnected}, alarms) do
    send_alert_to_slack(database_alarm())
    {:ok, alarms}
  end

  def handle_event({:clear_alarm, :database_disconnected}, alarms) do
    send_recovery_to_slack(database_alarm())
    {:ok, alarms}
  end

  def handle_event(event, state) do
    Logger.info("Unhandled alarm event: #{inspect(event)}")
    {:ok, state}
  end

  defp send_alert_to_slack(payload) do
    nil
  end

  defp send_recovery_to_slack(payload) do
    nil
  end

  defp database_alarm do
    nil
  end
end

