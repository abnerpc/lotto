defmodule Lotto.Draws.Attempt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attempts" do
    field :n1, :integer
    field :n2, :integer
    field :n3, :integer
    field :n4, :integer
    field :n5, :integer
    field :n6, :integer
    field :year, :integer

    has_one :match, Lotto.Draws.Match
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(attempt, attrs) do
    attempt
    |> cast(attrs, [:n1, :n2, :n3, :n4, :n5, :n6, :year])
    |> validate_required([:n1, :n2, :n3, :n4, :n5, :n6, :year])
  end
end
