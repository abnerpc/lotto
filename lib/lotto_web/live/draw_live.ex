defmodule LottoWeb.DrawLive do
  use LottoWeb, :live_view
  alias Lotto.Draws

  @attempts_length 10

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Draws.subscribe()
    end

    attempts = Draws.last_attempts(@attempts_length)
    attempt_ids = Enum.map(attempts, & &1.id)

    {:ok,
     socket
     |> assign(:attempt_ids, attempt_ids)
     |> stream(:attempts, attempts)
     |> stream(:matches, Draws.last_matches())}
  end

  def handle_info({:new_attempt, attempt}, socket) do
    current_ids = socket.assigns.attempt_ids
    id_to_remove =
      if length(current_ids) == @attempts_length do
        List.last(current_ids)
      else
        nil
      end

    new_ids =
      [attempt.id | current_ids]
      |> Enum.uniq()
      |> Enum.take(@attempts_length)

    socket =
      socket
      |> assign(:attempt_ids, new_ids)
      |> stream_insert(:attempts, attempt, at: 0)

    socket =
      if id_to_remove do
        stream_delete(socket, :attempts, %{id: id_to_remove})
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_info({:new_match, match}, socket) do
    {:noreply, stream_insert(socket, :matches, match)}
  end

end
