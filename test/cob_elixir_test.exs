defmodule CobElixirTest do
  use ExUnit.Case
  doctest CobElixir

  test "that a server is accepting connections" do
    opts = [:binary, active: true]
    assert {:ok, _socket} = :gen_tcp.connect('localhost', 8080, opts)
  end
end
