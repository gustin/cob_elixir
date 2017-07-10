defmodule CobElixirTest do
  use ExUnit.Case
  doctest CobElixir

  test "that a server is accepting connections" do
    import Supervisor.Spec

    children = [
      worker(Task, [CobElixir, :accept, []]),
    ]

    opts = [strategy: :one_for_one, name: CobElixir.Supervisor]
    Supervisor.start_link(children, opts)

    opts = [:binary, active: true]
    assert {:ok, _socket} = :gen_tcp.connect('localhost', 8080, opts)
  end
end
