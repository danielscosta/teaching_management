import Config

# Configure your database
config :teaching_management, TeachingManagement.Repo,
  hostname: System.get_env("PG_HOST", "localhost")
