defmodule CobElixir.HTTPHeader.ContentType do

  @doc ~S"""
  Generate the Content-Type HTTP Header.

  ## Examples

    iex> CobElixir.HTTPHeader.ContentType.mime_type("text/html")
    "Content-Type: text/html\r\n"

    iex> CobElixir.HTTPHeader.ContentType.mime_type("image/jpg")
    "Content-Type: image/jpg\r\n"
  """
  def mime_type(content_type) do
    "Content-Type: #{content_type}\r\n"
  end
end
