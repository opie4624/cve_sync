defmodule CveSync.MixProject do
  use Mix.Project

  def project do
    [
      app: :cve_sync,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
      # mod: {CveSync, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:memento, "~> 0.4"},
      {:stream_gzip, "~> 0.4"},
      {:jaxon, "~> 2.0"},
      {:mint, "~> 1.6"},
      {:castore, "~> 1.0"},
      {:tesla, "~> 1.12"},
      {:dialyxir, "~> 1.4", only: :dev, runtime: false}
    ]
  end
end
