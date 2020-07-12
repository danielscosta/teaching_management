defmodule TeachingManagementWeb.Resolvers.GroupResolver do
  alias TeachingManagement.Records

  def create_group(_, args, _) do
    Records.create_group(args)
  end
end
