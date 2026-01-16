defmodule Lotto.Generator do
  use GenServer

  alias Lotto.Draws

  @interval 1_000

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    schedule_tick()
    {:ok, state}
  end

  def handle_info(:tick, state) do
    generate_numbers()
      |> to_attrs()
      |> add_last_year()
      |> Draws.create_attempt()
    schedule_tick()
    {:noreply, state}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, @interval)
  end

  defp generate_numbers do
    Enum.take_random(1..60, 6)
  end

  defp to_attrs([a,b,c,d,e,f]) do
    %{n1: a, n2: b, n3: c, n4: d, n5: e, n6: f}
  end

  defp add_last_year(attrs) do
    Map.put(attrs, :year, Date.utc_today().year - 1)
  end

end
