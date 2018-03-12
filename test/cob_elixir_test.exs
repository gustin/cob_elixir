defmodule CobElixirTest do
  use ExUnit.Case

  setup do
    Application.stop(:cob_elixir)
    :ok = Application.start(:cob_elixir)
  end

  setup do
    opts = [:binary, packet: :raw, active: false]
    {:ok, socket} = :gen_tcp.connect('localhost', 8888, opts)
    {:ok, socket: socket}
  end

  @tag :wip
  test "that server handles a GET for the home page", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "GET / HTTP/1.1\r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == ~s"""
                    HTTP/1.1 200 OK\r
                    Content-Type: text/html\r
                    """
  end

  test "that server handles a GET request", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "GET /hello-world.html HTTP/1.1\r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == ~s"""
                    HTTP/1.1 200 OK\r
                    Content-Type: text/html\r
                    """
  end

  test "that server handles a POST request", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "POST /form HTTP/1.1\r\n My=data\r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == "HTTP/1.1 200 OK\r\n"
  end

  test "that server handles a PUT request", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "PUT /form HTTP/1.1\r\n My=data\r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == "HTTP/1.1 200 OK\r\n"
  end

  test "that server handles images", %{socket: socket} do
    :ok = :gen_tcp.send(socket, "GET /image.gif HTTP/1.1\r\n")
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    assert data == ~s"""
                    HTTP/1.1 200 OK\r
                    Content-Type: image/gif\r
                    """
  end
end
