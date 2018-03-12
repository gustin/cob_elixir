defmodule CobElixir do
  require Logger

  def accept do
    opts = [:binary, packet: :raw, active: false, reuseaddr: true]
    {:ok, http_client} = :gen_tcp.listen(8888, opts)
    Logger.info "Accepting connections on port 8888"

    {:ok, http_client} = :gen_tcp.accept(http_client)
    :ok = serve(http_client)
  end

  defp serve(http_client) do
    http_client
    |> read_http_request()
    |> write_http_response()

    :gen_tcp.close(http_client)
    serve(http_client)
  end

  defp read_http_request(http_client) do
    {:ok, data} = :gen_tcp.recv(http_client, 0)
    {CobElixir.Request.parse(data), http_client}
  end

  defp write_http_response({{:get, {:content_type, content_type},
                            {:body, content}},
                            http_client}) do
    status = CobElixir.HTTPHeader.Status.success
    content_type = CobElixir.HTTPHeader.ContentType.mime_type(content_type)
    :gen_tcp.send(http_client, "#{status}#{content_type}")
  end

  defp write_http_response({{:post, {:url, url}}, http_client}) do
    status = CobElixir.HTTPHeader.Status.success
    :gen_tcp.send(http_client, status)
  end

  defp write_http_response({{:put, {:url, url}}, http_client}) do
    status = CobElixir.HTTPHeader.Status.success
    :gen_tcp.send(http_client, status)
  end

  defp write_http_response({:error, _, http_client}) do
    :gen_tcp.send(http_client, "500 \r\n")
  end
end
