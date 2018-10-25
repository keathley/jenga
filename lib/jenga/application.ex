defmodule Jenga.Application do
  use Application

  alias Jenga.AlarmHandler

  def start(_type, _args) do
    config = [
      port: {"PORT", 4000},
      db_url: {"DB_URL", "localhost"},
    ]

    :gen_event.swap_handler(
      :alarm_handler,
      {:alarm_handler, :swap},
      {AlarmHandler, :ok})


    children = [
      {Jenga.Config, config},
      JengaWeb.Endpoint,
      {Jenga.DemoConnection, []},
      Jenga.Database.Supervisor,
    ]

    opts = [strategy: :one_for_one, name: Jenga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    JengaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
