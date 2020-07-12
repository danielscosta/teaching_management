defmodule TeachingManagementWeb.Schema do
  use Absinthe.Schema

  alias TeachingManagementWeb.Resolvers.GroupResolver
  alias TeachingManagementWeb.Resolvers.StudentResolver
  alias TeachingManagementWeb.Resolvers.TeacherResolver

  import_types(TeachingManagementWeb.Types.GroupTypes)
  import_types(TeachingManagementWeb.Types.StudentTypes)
  import_types(TeachingManagementWeb.Types.TeacherTypes)

  query do
    @desc "list students by group"
    field :list_students_by_group, list_of(:student) do
      arg(:group_id, non_null(:string))

      resolve(&StudentResolver.list_students_by_group/3)
    end
  end

  mutation do
    @desc "create a group"
    field :create_group, type: :group do
      arg(:name, non_null(:string))

      resolve(&GroupResolver.create_group/3)
    end

    @desc "create a student"
    field :create_student, type: :student do
      arg(:internal_code, non_null(:string))
      arg(:group_id, :string)

      resolve(&StudentResolver.create_student/3)
    end

    @desc "create a teacher"
    field :create_teacher, type: :teacher do
      arg(:document, non_null(:string))

      resolve(&TeacherResolver.create_teacher/3)
    end
  end
end
