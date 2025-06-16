defmodule GlixBackEnd.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GlixBackEndWeb.Telemetry,
      GlixBackEnd.Repo,
      {DNSCluster, query: Application.get_env(:glix_back_end, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GlixBackEnd.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GlixBackEnd.Finch},
      # Start a worker by calling: GlixBackEnd.Worker.start_link(arg)
      # {GlixBackEnd.Worker, arg},
      # Start to serve requests, typically the last entry
      GlixBackEndWeb.Endpoint,
      {Absinthe.Subscription, GlixBackEndWeb.Endpoint},
      AshGraphql.Subscription.Batcher,
      {AshAuthentication.Supervisor, [otp_app: :glix_back_end]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GlixBackEnd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GlixBackEndWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
