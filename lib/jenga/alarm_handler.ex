defmodule Jenga.AlarmHandler do
  require Logger

  def init({:ok, {:alarm_handler, _old_alarms}}) do
    Logger.info("Installing alarm handler")
    # alarms = %{fuses: MapSet.new()}
    {:ok, %{}}
  end

  # def handle_event({:set_alarm, {fuse, :fuse_blown}}, %{fuses: fuses} = alarms) do
  #   Logger.error("Fuse has been blown: #{fuse}")
  #   {:ok, %{alarms | fuses: MapSet.put(fuses, fuse)}}
  # end

  # def handle_event({:clear_alarm, alarm_id}, %{fuses: fuses} = alarms) do
  #   if MapSet.member?(fuses, alarm_id) do
  #     Logger.info("Fuse has re-healed: #{alarm_id}")
  #     {:ok, %{alarms | fuses: MapSet.delete(fuses, alarm_id)}}
  #   else
  #     {:ok, alarms}
  #   end
  # end

  def handle_event(event, state) do
    Logger.info("Unhandled alarm event: #{inspect(event)}")
    {:ok, state}
  end
end

