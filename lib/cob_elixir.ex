defmodule CobElixir do
  require Logger

  @moduledoc """
  Documentation for CobElixir.
  """

  @doc """
  """
  def accept do
    opts = [:binary, packet: :line, active: false, reuseaddr: true]
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

    serve(socket)
  end

  defp read_request(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data = CobElixir.Request.parse(data)
    data
  end

  defp write_response({:get, {:url, url}}, socket) do
    :gen_tcp.send(socket, "200 \r\n")
  end

  defp write_response({:error, _}, socket) do
    :gen_tcp.send(socket, "500 \r\n")
  end
end
