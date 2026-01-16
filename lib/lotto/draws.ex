defmodule Lotto.Draws do
  @moduledoc """
  The Draws context.
  """

  import Ecto.Query, warn: false
  alias Lotto.Repo
  alias Lotto.Draws.{Attempt, Match}
  alias Phoenix.PubSub

  @topic "draws"
  @lotto_results %{
    2025 => [9, 13, 21, 32, 33, 59]
  }

  @doc """
  Returns latest attempts.
  """
  def last_attempts(limit \\ 20) do
    from(a in Attempt,
      order_by: [desc: a.inserted_at],
      limit: ^limit
    )
    |> Repo.all()
  end

  def last_matches do
    Repo.all(Match)
  end

  @doc """
  Creates an attempt.
  """
  def create_attempt(attrs \\ %{}) do
    {:ok, attempt} =
      %Attempt{}
      |> Attempt.changeset(attrs)
      |> Repo.insert()

    if has_match?(attempt) do
      create_match(attempt)
    end

    PubSub.broadcast(
      Lotto.PubSub,
      @topic,
      {:new_attempt, attempt}
    )
  end

  defp create_match(attempt) do
    match =
      %Match{}
      |> Match.changeset(%{
        attempt_id: attempt.id,
        year: attempt.year
      })
      |> Repo.insert!()

    PubSub.broadcast(
      Lotto.PubSub,
      @topic,
      {:new_match, match}
    )
  end

  defp has_match?(attempt) do
    Map.get(@lotto_results, attempt.year) == attempt_numbers(attempt)
  end

  defp attempt_numbers(attempt) do
    [attempt.n1, attempt.n2, attempt.n3, attempt.n4, attempt.n5, attempt.n6] |> Enum.sort()
  end

  def subscribe do
    PubSub.subscribe(Lotto.PubSub, @topic)
  end
end
