defmodule Joba.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      JobaWeb.Telemetry,
      # Start the Ecto repository
      Joba.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Joba.PubSub},
      # Start Finch
      {Finch, name: Joba.Finch},
      # Start the Endpoint (http/https)
      JobaWeb.Endpoint,
      # Start a worker by calling: Joba.Worker.start_link(arg)
      # {Joba.Worker, arg}
      {Oban, Application.fetch_env!(:joba, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Joba.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JobaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
