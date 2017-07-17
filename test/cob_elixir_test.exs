defmodule CobElixirTest do
  use ExUnit.Case
  doctest CobElixir

  test "that a server is accepting connections" do
    opts = [:binary, active: true]
    assert {:ok, _socket} = :gen_tcp.connect('localhost', 8080, opts)
  end

  test "that server handles a GET request" do
    opts = [:binary, active: true]
    {:ok, socket } = :gen_tcp.connect('localhost', 8080, opts)
    :gen_tcp.send(socket, "GET /hello-world HTTP/1.1")
    assert { :status, 200 } = :gen_tcp.recv(socket, 0)
  end
end
