defmodule EventsGrapAPI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EventsGrapAPIWeb.Telemetry,
      EventsGrapAPI.Repo,
      {DNSCluster, query: Application.get_env(:events_grapAPI, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EventsGrapAPI.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EventsGrapAPI.Finch},
      # Start a worker by calling: EventsGrapAPI.Worker.start_link(arg)
      # {EventsGrapAPI.Worker, arg},
      # Start to serve requests, typically the last entry
      EventsGrapAPIWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventsGrapAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EventsGrapAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
