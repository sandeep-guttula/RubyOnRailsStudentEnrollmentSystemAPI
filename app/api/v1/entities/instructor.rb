class V1::Entities::Instructor < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Instructor ID" }
  expose :department, using: V1::Entities::Department, as: :department
  expose :year_of_exp, documentation: { type: "Integer", desc: "Years of Experience" }
  expose :user, using: V1::Entities::User, as: :user
end
