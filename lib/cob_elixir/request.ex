defmodule CobElixir.Request do
  @doc ~S"""
  Parses the given `line` into a command.

  ## Examples

      iex> CobElixir.Request.parse "GET \hello-world HTTP/1.1\r\n"
      {:get, {:url, "hello-world"}}
  """
  def parse(request) do


  end
end
