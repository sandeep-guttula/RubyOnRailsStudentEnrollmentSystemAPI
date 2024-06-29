class V1::Entities::InstructorCourse < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Assigned Course ID" }
  expose :course, using: V1::Entities::Course, as: :course
end
