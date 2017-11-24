defmodule CobElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :cob_elixir,
     version: "0.1.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {CobElixir.Application, []}]
  end

  defp deps do
    [{:mix_test_watch, "~> 0.5", only: :dev, runtime: false}]
  end
end
