defmodule TeachingManagement.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :document, :string

      timestamps()
    end

    create unique_index(:teachers, [:document])
  end
end
