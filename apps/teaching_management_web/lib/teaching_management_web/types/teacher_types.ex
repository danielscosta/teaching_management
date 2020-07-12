defmodule TeachingManagementWeb.Types.TeacherTypes do
  use Absinthe.Schema.Notation

  @desc "Teacher"
  object :teacher do
    @desc "The teacher id"
    field(:id, :id)
    @desc "The document of teacher"
    field(:document, :string)
  end
end
