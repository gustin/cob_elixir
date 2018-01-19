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

  defp write_response({:get, {:content_type, content_type}}, socket) do
    status = CobElixir.HTTPHeader.Status.success
    content_type = CobElixir.HTTPHeader.ContentType.mime_type(content_type)
    :gen_tcp.send(socket, "#{status}#{content_type}")
  end

  defp write_response({:post, {:url, url}}, socket) do
    status = CobElixir.HTTPHeader.Status.success
    :gen_tcp.send(socket, status)
  end

  defp write_response({:put, {:url, url}}, socket) do
    status = CobElixir.HTTPHeader.Status.success
    :gen_tcp.send(socket, status)
  end

  defp write_response({:error, _}, socket) do
    :gen_tcp.send(socket, "500 \r\n")
  end
end
