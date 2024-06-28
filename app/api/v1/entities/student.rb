class V1::Entities::Student < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Student ID" }
  expose :user do |student, options|
    {
      id: student.user.id,
      name: student.user.name,
      email: student.user.email,
      role: student.user.role,
      department: {
        id: student.department.id,
        name: student.department.name,
        description: student.department.description
      },
      semester: {
        id: student.semester.id,
        name: student.semester.name,
        start_date: student.semester.start_date.strftime("%Y-%m-%d"),
        end_date: student.semester.end_date.strftime("%Y-%m-%d")
      }
    }
  end
end
