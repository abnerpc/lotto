defmodule Lotto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LottoWeb.Telemetry,
      Lotto.Repo,
      {DNSCluster, query: Application.get_env(:lotto, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lotto.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Lotto.Finch},
      # Start a worker by calling: Lotto.Worker.start_link(arg)
      # {Lotto.Worker, arg},
      # Start to serve requests, typically the last entry
      LottoWeb.Endpoint,
      Lotto.Generator
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lotto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LottoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
