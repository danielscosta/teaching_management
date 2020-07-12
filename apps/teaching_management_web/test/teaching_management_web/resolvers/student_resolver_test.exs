defmodule TeachingManagementWeb.Resolvers.StudentResolverTest do
  use TeachingManagementWeb.ConnCase, async: true

  alias TeachingManagement.Accounts
  alias TeachingManagement.Records

  defp student_fixture(attrs \\ %{}, groups \\ []) do
    {:ok, student} =
      attrs
      |> Enum.into(%{internal_code: "some internal_code"})
      |> Accounts.create_student(groups)

    student
  end

  defp group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{name: "some name"})
      |> Records.create_group()

    group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "list students by group" do
    @query """
    query ListStudentsByGroup($group_id: String!) {
      listStudentsByGroup(groupId: $group_id) {
        id,
        internalCode,
        groups {
          id
          name
        }
      }
    }
    """

    test "renders students list when data is valid", %{conn: conn} do
      group = group_fixture()
      _student = student_fixture(%{}, [group])

      conn =
        post(conn, "/api/v1/graphql", %{
          query: @query,
          variables: %{group_id: group.id}
        })

      assert %{
               "listStudentsByGroup" => [
                 %{
                   "id" => id,
                   "internalCode" => "some internal_code",
                   "groups" => [%{"id" => group_id, "name" => group_name}]
                 }
               ]
             } = json_response(conn, 200)["data"]

      assert group_id == group.id
      assert group_name == group.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/v1/graphql", %{query: @query, variables: %{group_id: nil}})

      assert json_response(conn, 200)["errors"] != %{}
    end
  end

  describe "create student" do
    @mutation """
      mutation CreateStudent($internal_code: String!, $group_id: String) {
        createStudent(internalCode: $internal_code, groupId: $group_id) {
          id,
          internalCode,
          groups {
            id,
            name
          }
        }
      }
    """

    test "renders student when data is valid", %{conn: conn} do
      conn =
        post(conn, "/api/v1/graphql", %{
          query: @mutation,
          variables: %{internal_code: "some internal_code"}
        })

      assert %{
               "createStudent" => %{
                 "id" => id,
                 "internalCode" => "some internal_code",
                 "groups" => []
               }
             } = json_response(conn, 200)["data"]
    end

    test "renders student when data is valid with group_id", %{conn: conn} do
      group = group_fixture()

      conn =
        post(conn, "/api/v1/graphql", %{
          query: @mutation,
          variables: %{internal_code: "some internal_code", group_id: group.id}
        })

      assert %{
               "createStudent" => %{
                 "id" => id,
                 "internalCode" => "some internal_code",
                 "groups" => [%{"id" => group_id, "name" => group_name}]
               }
             } = json_response(conn, 200)["data"]

      assert group_id == group.id
      assert group_name == group.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/v1/graphql", %{query: @mutation, variables: %{internal_code: nil}})

      assert json_response(conn, 200)["errors"] != %{}
    end
  end
end
