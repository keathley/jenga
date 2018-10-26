defmodule Jenga.ExternalService do
  @fuse :external_service

  def fetch(params) do
    with :ok <- :fuse.ask(@fuse, :async_dirty),
         {:ok, result} <- make_call(params) do
      {:ok, result}
    else
      {:error, e} ->
        :ok = :fuse.melt(@fuse)
        {:error, e}

      :blown ->
        {:error, :service_is_down}
    end
  end
end
