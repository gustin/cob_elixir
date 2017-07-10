defmodule CobElixir do
  require Logger

  @moduledoc """
  Documentation for CobElixir.
  """

  @doc """
  """
  def accept do
    opts = [:binary, packet: :line, active: false, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(8080, opts)
    Logger.info "Accepting connections on port 8080"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = serve(client)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket

    serve(socket)
  end
end
