defmodule CobElixir.Body do

  @doc ~S"""
  Generate the Content-Type HTTP Header.

  ## Examples

    iex> CobElixir.Body.generate("text/html")
    "<html>H1</html>"

    #iex> CobElixir.HTTPHeader.ContentType.mime_type("image/jpg")
  """
  def generate(url) do
    "<html>Hi</html>"
  end
end
