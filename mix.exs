defmodule GlobalID.MixProject do
  use Mix.Project

  def project do
    [
      app: :global_id,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.11"},
      {:ecto_sql, "~> 3.11", only: :test},
      {:postgrex, ">= 0.0.0", only: :test}
    ]
  end
end
