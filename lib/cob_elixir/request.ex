defmodule CobElixir.Request do
  @doc ~S"""
  Parses a GET request.

  ## Examples

      iex> CobElixir.Request.parse "GET hello-world HTTP/1.1\r\n"
      {:get, {:url, "hello-world"}}
  """
  def parse("GET" <> request) do
    [_, url | rest] = String.split(request, " ")
    {:get, {:url, url}}
  end

  @doc ~S"""
  Parses a POST request.

  ## Examples

      iex> CobElixir.Request.parse "POST /form HTTP/1.1\r\n My=data\r\n"
      {:post, {:url, "/form"}}
  """
  def parse("POST" <> request) do
    [_, url | rest] = String.split(request, " ")
    {:post, {:url, url}}
  end

  @doc ~S"""
  Parses a PUT request.

  ## Examples

      iex> CobElixir.Request.parse "PUT /form HTTP/1.1\r\n My=data\r\n"
      {:put, {:url, "/form"}}
  """
  def parse("PUT" <> request) do
    [_, url | rest] = String.split(request, " ")
    {:put, {:url, url}}
  end

  @doc ~S"""
  Parses everything else.

  ## Examples

      iex> CobElixir.Request.parse "PATCH hello-world HTTP/1.1\r\n"
      {:error, :unsupported}
  """
  def parse(request) do
    {:error, :unsupported}
  end
end


