defmodule Lotto.DrawsTest do
  use Lotto.DataCase

  alias Lotto.Draws

  describe "attempt" do
    alias Lotto.Draws.Attempt

    import Lotto.DrawsFixtures

    @invalid_attrs %{n1: nil, n2: nil, n3: nil, n4: nil, n5: nil, n6: nil}

    test "list_attempt/0 returns all attempt" do
      attempt = attempt_fixture()
      assert Draws.list_attempt() == [attempt]
    end

    test "get_attempt!/1 returns the attempt with given id" do
      attempt = attempt_fixture()
      assert Draws.get_attempt!(attempt.id) == attempt
    end

    test "create_attempt/1 with valid data creates a attempt" do
      valid_attrs = %{n1: 42, n2: 42, n3: 42, n4: 42, n5: 42, n6: 42}

      assert {:ok, %Attempt{} = attempt} = Draws.create_attempt(valid_attrs)
      assert attempt.n1 == 42
      assert attempt.n2 == 42
      assert attempt.n3 == 42
      assert attempt.n4 == 42
      assert attempt.n5 == 42
      assert attempt.n6 == 42
    end

    test "create_attempt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Draws.create_attempt(@invalid_attrs)
    end

    test "update_attempt/2 with valid data updates the attempt" do
      attempt = attempt_fixture()
      update_attrs = %{n1: 43, n2: 43, n3: 43, n4: 43, n5: 43, n6: 43}

      assert {:ok, %Attempt{} = attempt} = Draws.update_attempt(attempt, update_attrs)
      assert attempt.n1 == 43
      assert attempt.n2 == 43
      assert attempt.n3 == 43
      assert attempt.n4 == 43
      assert attempt.n5 == 43
      assert attempt.n6 == 43
    end

    test "update_attempt/2 with invalid data returns error changeset" do
      attempt = attempt_fixture()
      assert {:error, %Ecto.Changeset{}} = Draws.update_attempt(attempt, @invalid_attrs)
      assert attempt == Draws.get_attempt!(attempt.id)
    end

    test "delete_attempt/1 deletes the attempt" do
      attempt = attempt_fixture()
      assert {:ok, %Attempt{}} = Draws.delete_attempt(attempt)
      assert_raise Ecto.NoResultsError, fn -> Draws.get_attempt!(attempt.id) end
    end

    test "change_attempt/1 returns a attempt changeset" do
      attempt = attempt_fixture()
      assert %Ecto.Changeset{} = Draws.change_attempt(attempt)
    end
  end
end
