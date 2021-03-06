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
  def parse("GET" <> get_request) do
    get_request |>
      String.trim |>
      identify_home_page_request |>
      break_apart
  end

  def parse("POST" <> post_request) do
    [_, url | rest] = String.split(post_request, " ")
    {:post, {:url, url}}
  end

  def parse("PUT" <> put_request) do
    [_, url | rest] = String.split(put_request, " ")
    {:put, {:url, url}}
  end

  def parse(everything_else) do
    {:error, :unsupported}
  end

  defp identify_home_page_request(request) do
    [url, _] = String.split(request, " ")
    cond do
      String.contains?(url, ".") ->
        {:page, request}
      true ->
        {:home, request}
    end
  end

  defp break_apart({:home, request}) do
    get_request    = String.trim(request)
    [url, version] = String.split(get_request, " ")
    {:get, {:content_type, "text/html"}}
  end

  defp break_apart({:page, request}) do
    [url, version] = String.split(request, " ")
    [file_name, extension]      = String.split(url, ".")
    {:get, {:content_type, CobElixir.MimeType.content_type(extension)}}
  end
end


