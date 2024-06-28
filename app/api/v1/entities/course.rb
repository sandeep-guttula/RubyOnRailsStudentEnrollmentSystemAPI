class V1::Entities::Course < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Course ID" }
  expose :title, documentation: { type: "String", desc: "Course Name" }
  expose :description, documentation: { type: "String", desc: "Course Description" }
  expose :capacity, documentation: { type: "Integer", desc: "Course Capacity" }
  expose :self_enroll_allowed, documentation: { type: "Integer", desc: "Course Capacity" }
  expose :department, using: V1::Entities::Department, as: :department
end
