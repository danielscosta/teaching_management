defmodule TeachingManagement.AccountsTest do
  use TeachingManagement.DataCase

  alias TeachingManagement.Accounts

  describe "teachers" do
    alias TeachingManagement.Accounts.Teacher

    @valid_document Brcpfcnpj.cpf_generate()
    @valid_attrs %{document: @valid_document}

    @invalid_attrs %{document: nil}

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Accounts.create_teacher(@valid_attrs)
      assert teacher.document == @valid_document
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_teacher(@invalid_attrs)
    end

    test "create_teacher/1 with invalid document returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Accounts.create_teacher(%{@valid_attrs | document: "0"})
    end
  end

  describe "students" do
    alias TeachingManagement.Accounts.Student
    alias TeachingManagement.Records

    @valid_attrs %{internal_code: "some internal_code"}
    @invalid_attrs %{internal_code: nil}

    def student_fixture(attrs \\ %{}, groups \\ []) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_student(groups)

      student
    end

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(%{name: "some name"})
        |> Records.create_group()

      group
    end

    test "list_students_by_group/1 returns all students" do
      group = group_fixture()
      student = student_fixture(%{}, [group])
      assert Accounts.list_students_by_group(group.id) == [student]
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Accounts.create_student(@valid_attrs)
      assert student.internal_code == "some internal_code"
    end

    test "create_student/1 with valid data creates a student with group" do
      group = group_fixture()
      assert {:ok, %Student{} = student} = Accounts.create_student(@valid_attrs, [group])
      assert student.internal_code == "some internal_code"
      assert student.groups == [group]
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_student(@invalid_attrs)
    end
  end
end
