defmodule TeachingManagementWeb.Resolvers.StudentResolver do
  alias TeachingManagement.Accounts
  alias TeachingManagement.Records

  def list_students_by_group(_, args, _) do
    {:ok, Accounts.list_students_by_group(args[:group_id])}
  end

  def create_student(_, args, _) do
    groups = if is_nil(args[:group_id]), do: [], else: [Records.get_group!(args[:group_id])]
    Accounts.create_student(args, groups)
  end
end
