class V1::Entities::Course < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course ID" }
  expose :title, documentation: { type: "String", desc: "Course Name" }
  expose :description, documentation: { type: "String", desc: "Course Description" }
  expose :capacity, documentation: { type: "Integer", desc: "Course Capacity" }
  expose :self_enroll_allowed, documentation: { type: "Integer", desc: "Course Capacity" }
  expose :department_id, documentation: { type: "Integer", desc: "Department ID" }
  expose :created_at, documentation: { type: "DateTime", desc: "Course Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Course Updated At" }
end