class V1::Entities::CoursePrerequisite < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Prerequisite ID" }
  expose :course_id, documentation: { type: "Integer", desc: "Course ID" }
  expose :prerequisite_course_id, documentation: { type: "Integer", desc: "Prerequisite Course ID" }
  expose :course, using: V1::Entities::Course, as: :course
  expose :prerequisite_course, using: V1::Entities::Course, as: :prerequisite_course
end

