defmodule Lotto.Repo.Migrations.CreateAttempt do
  use Ecto.Migration

  def change do
    create table(:attempts) do
      add :n1, :integer
      add :n2, :integer
      add :n3, :integer
      add :n4, :integer
      add :n5, :integer
      add :n6, :integer
      add :year, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
