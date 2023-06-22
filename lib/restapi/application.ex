defmodule Restapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RestapiWeb.Telemetry,
      # Start the Ecto repository
      Restapi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Restapi.PubSub},
      # Start Finch
      {Finch, name: Restapi.Finch},
      # Start the Endpoint (http/https)
      RestapiWeb.Endpoint
      # Start a worker by calling: Restapi.Worker.start_link(arg)
      # {Restapi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Restapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RestapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
