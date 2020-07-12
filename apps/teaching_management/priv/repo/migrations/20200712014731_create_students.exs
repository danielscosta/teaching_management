defmodule TeachingManagement.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :internal_code, :string

      timestamps()
    end

    create unique_index(:students, [:internal_code])
  end
end
