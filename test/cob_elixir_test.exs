defmodule CobElixirTest do
  use ExUnit.Case

  setup do
    Application.stop(:cob_elixir)
    :ok = Application.start(:cob_elixir)
  end

  test "that a server is accepting connections" do
    opts = [:binary, active: true]
    assert {:ok, _socket} = :gen_tcp.connect('localhost', 8080, opts)
  end

  test "that server handles a GET request" do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket } = :gen_tcp.connect('localhost', 8080, opts)
    :ok = :gen_tcp.send(socket, "GET /hello-world HTTP/1.1 \r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == "200 \r\n"
  end
end
