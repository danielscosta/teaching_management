defmodule TeachingManagement.RecordsTest do
  use TeachingManagement.DataCase

  alias TeachingManagement.Records

  describe "groups" do
    alias TeachingManagement.Records.Group

    @valid_attrs %{name: "some name"}
    @invalid_attrs %{name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_group()

      group
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Records.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Records.create_group(@valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_group(@invalid_attrs)
    end
  end
end
