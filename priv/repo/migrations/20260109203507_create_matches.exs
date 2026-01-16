defmodule Lotto.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :year, :integer
      add :attempt_id, references(:attempts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:matches, [:attempt_id])
    create unique_index(:matches, [:year, :attempt_id])
  end
end
