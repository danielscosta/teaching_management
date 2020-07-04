defmodule TeachingManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TeachingManagement.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TeachingManagement.PubSub}
      # Start a worker by calling: TeachingManagement.Worker.start_link(arg)
      # {TeachingManagement.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TeachingManagement.Supervisor)
  end
end
