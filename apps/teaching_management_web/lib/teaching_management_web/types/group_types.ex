defmodule TeachingManagementWeb.Types.GroupTypes do
  use Absinthe.Schema.Notation

  @desc "Group of students"
  object :group do
    @desc "The group id"
    field(:id, :id)
    @desc "The name of the group"
    field(:name, :string)
  end
end
