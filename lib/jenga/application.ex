defmodule Jenga.Application do
  use Application

  def start(_type, _args) do
    config = [
      port: "PORT",
      db_url: "DB_URL",
    ]

    children = [
      {Jenga.Config, config},
      Jenga.Repo,
      JengaWeb.Endpoint,
    ]

    opts = [strategy: :one_for_one, name: Jenga.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    JengaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
