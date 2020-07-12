defmodule TeachingManagementWeb.Resolvers.GroupResolverTest do
  use TeachingManagementWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create group" do
    @mutation """
      mutation CreateGroup($name: String!) {
        createGroup(name: $name) {
          id,
          name
        }
      }
    """

    test "renders group when data is valid", %{conn: conn} do
      conn =
        post(conn, "/api/v1/graphql", %{
          query: @mutation,
          variables: %{name: "some name"}
        })

      assert %{"createGroup" => %{"id" => id, "name" => "some name"}} =
               json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/v1/graphql", %{query: @mutation, variables: %{name: nil}})

      assert json_response(conn, 200)["errors"] != %{}
    end
  end
end
