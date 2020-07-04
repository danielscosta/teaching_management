defmodule TeachingManagement.Repo do
  use Ecto.Repo,
    otp_app: :teaching_management,
    adapter: Ecto.Adapters.Postgres
end
