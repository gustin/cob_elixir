defmodule CobElixir do
  require Logger

  @moduledoc """
  Documentation for CobElixir.
  """

  @doc """
  """
  def accept do
    opts = [:binary, packet: :raw, active: false, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(8080, opts)
    Logger.info "Accepting connections on port 8080"
    loop_acceptor(socket)
  end


  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    :ok = serve(client)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_request()
    |> write_response(socket)

    :gen_tcp.close(socket)
    serve(socket)
  end

  defp read_request(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    Logger.info "Read #{data}"
    CobElixir.Request.parse(data)
  end

  defp write_response({:get, {:url, url}}, socket) do
    #    status = CobElixir.Response.two_hundread_status
    status = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\nHello World!"
    Logger.info "Write #{status}"
    :gen_tcp.send(socket, status)
  end

  defp write_response({:error, _}, socket) do
    :gen_tcp.send(socket, "500 \r\n")
  end
end
