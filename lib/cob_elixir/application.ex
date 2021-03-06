defmodule CobElixir.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Task, [CobElixir, :accept, []])
    ]

    opts = [strategy: :one_for_one, name: CobElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
