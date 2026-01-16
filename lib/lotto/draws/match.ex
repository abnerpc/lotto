defmodule Lotto.Draws.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :year, :integer
    belongs_to :attempt, Lotto.Draws.Attempt

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:year, :attempt_id])
    |> validate_required([:year, :attempt_id])
    |> foreign_key_constraint(:attempt_id)
  end
end
