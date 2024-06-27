class V1::Entities::CourseInstructor < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Instructor ID" }
  expose :course_id, documentation: { type: "Integer", desc: "Course ID" }
  expose :instructor_id, documentation: { type: "Integer", desc: "Instructor ID" }
  expose :created_at, documentation: { type: "DateTime", desc: "Course Instructor Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Course Instructor Updated At" }
end
