defmodule TeachingManagement.Accounts.Student do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias TeachingManagement.Records.Group

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :internal_code, :string
    many_to_many :groups, Group, join_through: "students_groups"

    timestamps()
  end

  @doc false
  def changeset(student, attrs, groups \\ []) do
    student
    |> cast(attrs, [:internal_code])
    |> validate_required([:internal_code])
    |> put_assoc(:groups, groups)
  end
end
