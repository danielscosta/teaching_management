# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :teaching_management,
  ecto_repos: [TeachingManagement.Repo]

config :teaching_management_web,
  ecto_repos: [TeachingManagement.Repo],
  generators: [context_app: :teaching_management, binary_id: true]

# Configures the endpoint
config :teaching_management_web, TeachingManagementWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Vzl5to2V12gcJWbpP0FkgrRRzARVsPzKMUhDAwrP020xFKpfVl5DINvHptcQsLFk",
  render_errors: [view: TeachingManagementWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TeachingManagement.PubSub,
  live_view: [signing_salt: "FDFs++MH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
