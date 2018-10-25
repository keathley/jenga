defmodule Jenga.DemoConnection do
  use GenServer

  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    wait_for = 3_000 + backoff() + jitter()
    Process.send_after(self(), :try_connect, wait_for)
    {:ok, %{state: :disconnected}}
  end

  def bad_init(opts) do
    do_connect(opts)
    {:ok, %{state: :disconnected}}
  end

  def handle_info(:try_connect, state) do
    # Logger.warn "Trying to connect"
    # ... try to connect
    {:noreply, state}
  end

  def backoff do
    0
  end

  def jitter do
    0
  end

  defp do_connect(opts), do: nil
end
