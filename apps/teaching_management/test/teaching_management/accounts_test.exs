defmodule TeachingManagement.AccountsTest do
  use TeachingManagement.DataCase

  alias TeachingManagement.Accounts

  describe "teachers" do
    alias TeachingManagement.Accounts.Teacher

    @valid_attrs %{document: Brcpfcnpj.cpf_generate()}
    @update_attrs %{document: Brcpfcnpj.cpf_generate()}
    @invalid_attrs %{document: nil}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert Accounts.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert Accounts.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Accounts.create_teacher(@valid_attrs)
      assert teacher.document == "some document"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_teacher(@invalid_attrs)
    end

    test "create_teacher/1 with invalid document returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_teacher(%{@valid_attrs | document: "0"})
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = Accounts.update_teacher(teacher, @update_attrs)
      assert teacher.document == "some updated document"
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_teacher(teacher, @invalid_attrs)
      assert teacher == Accounts.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = Accounts.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_teacher!(teacher.id) end
    end
  end
end
