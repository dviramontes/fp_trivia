defmodule FpTrivia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FpTriviaWeb.Telemetry,
      FpTrivia.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:fp_trivia, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:fp_trivia, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FpTrivia.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FpTrivia.Finch},
      # Start a worker by calling: FpTrivia.Worker.start_link(arg)
      # {FpTrivia.Worker, arg},
      # Start to serve requests, typically the last entry
      FpTriviaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FpTrivia.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FpTriviaWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
