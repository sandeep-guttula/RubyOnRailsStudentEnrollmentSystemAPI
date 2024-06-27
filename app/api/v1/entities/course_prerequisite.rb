class V1::Entities::CoursePrerequisite < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Prerequisite ID" }
  expose :course_id, documentation: { type: "Integer", desc: "Course ID" }
  expose :prerequisite_course_id, documentation: { type: "Integer", desc: "Prerequisite ID" }
  expose :created_at, documentation: { type: "DateTime", desc: "Course Prerequisite Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Course Prerequisite Updated At" }
end
