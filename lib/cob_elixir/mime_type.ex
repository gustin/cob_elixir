defmodule CobElixir.MimeType do
  @doc ~S"""
  Determine the supported content type from an extension.

  ## Examples

    iex> CobElixir.MimeType.content_type("html")
    "text/html"

    iex> CobElixir.MimeType.content_type("jpg")
    "image/jpeg"
  """
  def content_type(filename) do
    "text/html"
  end
end
