defmodule Lotto.Repo do
  use Ecto.Repo,
    otp_app: :lotto,
    adapter: Ecto.Adapters.Postgres
end
