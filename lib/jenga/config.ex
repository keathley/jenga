defmodule Jenga.Config do
  use GenServer

  def start_link(desired_config) do
    GenServer.start_link(__MODULE__, desired_config, name: __MODULE__)
  end

  def get(key) do
    case :ets.lookup(:jenga_config, key) do
      [] ->
        nil
      [{^key, value}] ->
        value
    end
  end

  def init(desired) do
    :jenga_config = :ets.new(:jenga_config, [:set, :protected, :named_table])

    case load_config(:jenga_config, desired) do
      :ok ->
        {:ok, %{table: :jenga_config, desired: desired}}

      :error ->
        {:stop, :could_not_load_config}
    end
  end

  defp load_config(table, config, retry_count \\ 0)
  defp load_config(_table, [], _), do: :ok
  defp load_config(_table, _, 10), do: :error
  defp load_config(table, [{k, {v, default}} | tail], retry_count) do
    case System.get_env(v) do
      nil ->
        :ets.insert(table, {k, default})
        load_config(table, tail, retry_count)
        # load_config(table, [{k, v} | tail], retry_count + 1)

      value ->
        :ets.insert(table, {k, value})
        load_config(table, tail, retry_count)
    end
  end
end
