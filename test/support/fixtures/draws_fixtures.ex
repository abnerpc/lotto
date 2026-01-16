defmodule Lotto.DrawsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lotto.Draws` context.
  """

  @doc """
  Generate a attempt.
  """
  def attempt_fixture(attrs \\ %{}) do
    {:ok, attempt} =
      attrs
      |> Enum.into(%{
        n1: 42,
        n2: 42,
        n3: 42,
        n4: 42,
        n5: 42,
        n6: 42
      })
      |> Lotto.Draws.create_attempt()

    attempt
  end
end
