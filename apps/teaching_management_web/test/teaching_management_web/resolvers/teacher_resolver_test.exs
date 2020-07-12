defmodule TeachingManagementWeb.Resolvers.TeacherResolverTest do
  use TeachingManagementWeb.ConnCase, async: true

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create teacher" do
    @valid_document Brcpfcnpj.cpf_generate()
    @mutation """
      mutation CreateTeacher($document: String!) {
        createTeacher(document: $document) {
          id,
          document
        }
      }
    """

    test "renders teacher when data is valid", %{conn: conn} do
      conn =
        post(conn, "/api/v1/graphql", %{
          query: @mutation,
          variables: %{document: @valid_document}
        })

      assert %{"createTeacher" => %{"id" => id, "document" => @valid_document}} =
               json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/v1/graphql", %{query: @mutation, variables: %{document: nil}})

      assert json_response(conn, 200)["errors"] != %{}
    end
  end
end
