defmodule TeachingManagementWeb.Types.StudentTypes do
  use Absinthe.Schema.Notation

  @desc "Group of students"
  object :student_groups do
    @desc "The group id"
    field(:id, :id)
    @desc "The name of the group"
    field(:name, :string)
  end

  @desc "Student"
  object :student do
    @desc "The student id"
    field(:id, :id)
    @desc "The internal_code of student"
    field(:internal_code, :string)
    @desc "Groups that student belongs"
    field(:groups, list_of(:student_groups))
  end
end
