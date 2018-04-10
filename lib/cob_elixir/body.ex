defmodule CobElixir.Body do

  @doc ~S"""
  Load the body and return the contents from a file.

  ## Examples

    iex> CobElixir.Body.generate("text/html")
    "<html>H1</html>"

    #iex> CobElixir.HTTPHeader.ContentType.mime_type("image/jpg")
  """
  def content(url, content_type) do
    content_type |> String.split("/") |> load_body
  end

  defp load_body(["text", type]) do
    "<html>Hi</html>"
  end

  defp load_body(["image", extension]) do
    {:ok, data} = File.read("test/cob_elixir/images/image.jpeg")
    data
  end
end
