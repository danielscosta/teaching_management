defmodule TeachingManagement.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TeachingManagement.Repo

  alias TeachingManagement.Accounts.Teacher

  @doc """
  Creates a teacher.

  ## Examples

      iex> create_teacher(%{field: value})
      {:ok, %Teacher{}}

      iex> create_teacher(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teacher(attrs \\ %{}) do
    %Teacher{}
    |> Teacher.changeset(attrs)
    |> Repo.insert()
  end

  alias TeachingManagement.Accounts.Student

  @doc """
  Returns the list of students by group.

  ## Examples

      iex> list_students_by_group(group_id)
      [%Student{}, ...]

  """
  def list_students_by_group(group_id) do
    Student
    |> join(:inner, [s], g in assoc(s, :groups))
    |> where([s, g], g.id == ^group_id)
    |> Repo.all()
    |> Repo.preload([:groups])
  end

  @doc """
  Creates a student.

  ## Examples

      iex> create_student(%{field: value})
      {:ok, %Student{}}

      iex> create_student(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student(attrs \\ %{}, groups \\ []) do
    %Student{}
    |> Student.changeset(attrs, groups)
    |> Repo.insert()
  end
end
