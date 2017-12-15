defmodule CobElixir.MimeType do
  @doc ~S"""
  Determine the supported content type from an extension.

  ## Examples

    iex> CobElixir.MimeType.content_type("html")
    "text/html"

    iex> CobElixir.MimeType.content_type("jpg")
    "image/jpeg"
  """
  def content_type(file_extension), do: match_type(file_extension)

  @mime_types %{
    "css"  => "text/css",
    "html" => "text/html",
    "gif"  => "image/gif",
    "jpeg" => "image/jpeg", "jpg" => "image/jpeg",
    "js"   => "application/javascript",
    "png"  => "image/png"
  }

  for {extension, type} <- @mime_types do
    defp match_type(unquote(extension)), do: unquote(type)
  end

  defp match_type(extension) do
    {:error, :unsupported}
  end
end
