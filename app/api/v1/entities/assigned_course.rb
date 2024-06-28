class V1::Entities::AssignedCourse < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Assigned Course ID" }
  expose :course, using: V1::Entities::Course, as: :course
  expose :student, using: V1::Entities::User, as: :students
end
