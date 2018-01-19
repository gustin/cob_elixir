defmodule CobElixir.Request do
  @doc ~S"""
  Parses a GET request.

  ## Examples

      iex> CobElixir.Request.parse "GET / HTTP/1.1\r\n"
      {:get, {:content_type, "text/html"}}

      iex> CobElixir.Request.parse "GET /hello-world.html HTTP/1.1\r\n"
      {:get, {:content_type, "text/html"}}

      iex> CobElixir.Request.parse "POST /form HTTP/1.1\r\n My=data\r\n"
      {:post, {:url, "/form"}}

      iex> CobElixir.Request.parse "PUT /form HTTP/1.1\r\n My=data\r\n"
      {:put, {:url, "/form"}}

      iex> CobElixir.Request.parse "PATCH hello-world HTTP/1.1\r\n"
      {:error, :unsupported}
  """
  def parse("GET" <> request) do
    [_, url | rest] = String.split(request, " ")
    [_, extension] = String.split(url, ".")
    {:get, {:content_type, CobElixir.MimeType.content_type(extension)}}
  end

  def parse("POST" <> request) do
    [_, url | rest] = String.split(request, " ")
    {:post, {:url, url}}
  end

  def parse("PUT" <> request) do
    [_, url | rest] = String.split(request, " ")
    {:put, {:url, url}}
  end

  def parse(request) do
    {:error, :unsupported}
  end
end


