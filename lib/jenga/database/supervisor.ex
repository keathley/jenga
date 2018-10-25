defmodule Jenga.Database.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      Jenga.Database.Watchdog,
      Jenga.Repo,
    ]

    strategy = [strategy: :one_for_one]

    Supervisor.init(children, strategy)
  end
end
