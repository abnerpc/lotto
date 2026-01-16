defmodule Lotto.Release do
  @app :lotto

  def migrate do
    load_app()

    for repo <- repos() do
      Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    Ecto.Migrator.run(repo, :down, to: version)
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
