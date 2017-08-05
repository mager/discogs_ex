defmodule DiscogsEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :discogs_ex,
      version: "0.0.1",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      name: "DiscogsEx",
      description: "An Elixir library for Discogs API 2.0.",
      source_url: "https://github.com/mager/discogs_ex",
      package: package(),
      docs: [
        main: "DiscogsEx",
        extras: ["README.md"],
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "vcr": :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test,
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [
        :logger, :httpoison, :exjsx,
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.12"},
      {:exjsx, "~> 3.2"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:meck, "~> 0.8", only: :test},
      {:excoveralls, "~> 0.7", only: :test},
      {:exvcr, "~> 0.8", only: :test},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
    ]
  end

  defp package do
    [
      name: :discogs_ex,
      maintainers: ["Andrew Mager"],
      licenses: ["BSD 3-Clause"],
      links: %{"GitHub" => "https://github.com/mager/discogs_ex"}
    ]
  end
end
