defmodule HelloAll.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelloAllWeb.Telemetry,
      HelloAll.Repo,
      {DNSCluster, query: Application.get_env(:hello_all, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelloAll.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HelloAll.Finch},
      # Start a worker by calling: HelloAll.Worker.start_link(arg)
      # {HelloAll.Worker, arg},
      # Start to serve requests, typically the last entry
      HelloAllWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloAll.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloAllWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
