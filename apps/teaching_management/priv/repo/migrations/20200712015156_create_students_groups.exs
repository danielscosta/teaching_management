defmodule TeachingManagement.Repo.Migrations.CreateStudentsGroups do
  use Ecto.Migration

  def change do
    create table(:students_groups, primary_key: false) do
      add :student_id, references(:students, on_delete: :nothing, type: :binary_id)
      add :group_id, references(:groups, on_delete: :nothing, type: :binary_id)
    end
  end
end
