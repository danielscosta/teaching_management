defmodule TeachingManagement.Accounts.Teacher do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teachers" do
    field :document, :string

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:document])
    |> validate_required([:document])
    |> unique_constraint(:document)
    |> format_document()
    |> validate_cpf(:document)
  end

  defp format_document(%{changes: %{document: document}} = changeset),
    do: put_change(changeset, :document, String.replace(document, ~r/[^\d]/, ""))

  defp format_document(changeset), do: changeset
end
