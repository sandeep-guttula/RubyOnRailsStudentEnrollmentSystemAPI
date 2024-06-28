class V1::Entities::CourseInstructor < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Instructor ID" }
  expose :instructor, using: V1::Entities::User, as: :instructor
end
