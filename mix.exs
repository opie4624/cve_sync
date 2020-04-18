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
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:memento, "~> 0.3.1"},
      {:stream_gzip, "~> 0.4.0"},
      {:jaxon, "~> 2.0.0-alpha"},
      {:mint, "~> 0.4.0"},
      {:castore, "~> 0.1.0"},
      {:tesla, "~> 1.3.0"}
    ]
  end
end
