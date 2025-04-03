defmodule Mojo.MixProject do
  use Mix.Project

  def project do
    [
      app: :mojo,
      version: "0.1.1",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Mojo",
      source_url: "https://github.com/bhavanvir/mojo"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Mojo is a lightweight and flexible package that lets you create and manage custom dictionaries for text validation. Whether you need to enforce specific terminology, filter unwanted words, or ensure consistency in documents, Mojo makes it simple."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bhavanvir/mojo"}
    ]
  end
end
