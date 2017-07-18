defmodule CobElixirTest do
  use ExUnit.Case

  setup do
    Application.stop(:cob_elixir)
    :ok = Application.start(:cob_elixir)
  end

  setup do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket} = :gen_tcp.connect('localhost', 8080, opts)
    {:ok, socket: socket}
  end

  test "that server handles a GET request", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "GET /hello-world HTTP/1.1 \r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == "200 \r\n"
  end

  test "that server only responds to GET requests", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "POST /hello-world HTTP/1.1 \r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data != "200 \r\n"
  end
end
