class V1::Entities::Department < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Department ID" }
  expose :name, documentation: { type: "String", desc: "Department Name" }
  expose :description, documentation: { type: "String", desc: "Department Description" }
  expose :created_at, documentation: { type: "DateTime", desc: "Department Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Department Updated At" }
end
