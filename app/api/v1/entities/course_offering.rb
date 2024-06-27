class V1::Entities::CourseOffering < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course Offering ID" }
  expose :course_id, documentation: { type: "Integer", desc: "Course ID" }
  expose :semester_id, documentation: { type: "Integer", desc: "Semester ID" }
  expose :department_id, documentation: { type: "Integer", desc: "Department ID" }
end
