class V1::Entities::CourseDepartment < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Department ID" }
  expose :course, using: V1::Entities::Course, as: :course
  expose :department, using: V1::Entities::Department, as: :department
end