defmodule CobElixir do
  @moduledoc """
  Documentation for CobElixir.
  """

  @doc """
  """
  def accept do
    opts = [:binary, packet: :line, active: false, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(8080, opts)
  end
end
