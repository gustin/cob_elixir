defmodule CobElixirTest do
  use ExUnit.Case
  doctest CobElixir

  test "that a server is listening" do
    opts = [:binary, active: false]
    assert {:ok, socket} = :gen_tcp.connect('localhost', 8080, opts)
  end
end
