defmodule Duplo.MixProject do
  use Mix.Project

  def project do
    [
      app: :duplo,
      version: "0.1.1",
      elixir: "~> 1.8",
      name: "Duplo",
      description:
        "Duplo is a HTML buiilder based on function calls. Instead of writing whole HTML you can simple call functions.",
      source_url: "https://github.com/nicklayb/duplo",
      start_permanent: Mix.env() == :prod,
      deps: [
        {:ex_doc, ">= 0.0.0", only: :dev}
      ],
      package: package()
    ]
  end

  defp package do
    [
      maintainers: ["Nicolas Boisvert"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nicklayb/duplo"}
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
