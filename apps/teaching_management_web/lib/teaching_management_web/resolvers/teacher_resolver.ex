defmodule TeachingManagementWeb.Resolvers.TeacherResolver do
  alias TeachingManagement.Accounts

  def create_teacher(_, args, _) do
    Accounts.create_teacher(args)
  end
end
