class V1::Entities::Instructor < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Instructor ID" }
  expose :department_id, documentation: { type: "Integer", desc: "Department ID" }
  expose :year_of_exp, documentation: { type: "Integer", desc: "Years of Experience" }
  expose :user, using: V1::Entities::User, as: :user
end
