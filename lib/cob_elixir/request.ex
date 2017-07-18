defmodule CobElixir.Request do
  @doc ~S"""
  Parses a GET request.

  ## Examples

      iex> CobElixir.Request.parse "GET hello-world HTTP/1.1\r\n"
      {:get, {:url, "hello-world"}}
  """
  def parse("GET" <> request) do
    [_, url, _] = String.split(request, " ")
    {:get, {:url, url}}
  end

  @doc ~S"""
  Parses everything else.

  ## Examples

      iex> CobElixir.Request.parse "POST hello-world HTTP/1.1\r\n"
      {:error, :unsupported}
  """
  def parse(request) do
    {:error, :unsupported}
  end
end


