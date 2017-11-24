defmodule CobElixir do
  require Logger

  def accept do
    opts = [:binary, packet: :raw, active: false, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(8080, opts)
    Logger.info "Accepting connections on port 8080"

    {:ok, client} = :gen_tcp.accept(socket)
    :ok = serve(client)
  end

  defp serve(client) do
    client
    |> read_request()
    |> write_response(client)

    :gen_tcp.close(client)
    serve(client)
  end

  defp read_request(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    CobElixir.Request.parse(data)
  end

  defp write_response({:get, {:url, url}}, socket) do
    status = CobElixir.Status.two_hundread_status
    :gen_tcp.send(socket, status)
  end

  defp write_response({:post, {:url, url}}, socket) do
    status = CobElixir.Status.two_hundread_status
    :gen_tcp.send(socket, status)
  end

  defp write_response({:error, _}, socket) do
    :gen_tcp.send(socket, "500 \r\n")
  end
end
