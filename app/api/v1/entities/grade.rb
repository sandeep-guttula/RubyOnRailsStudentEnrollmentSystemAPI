class V1::Entities::Grade < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Grade ID" }
  expose :start_from, documentation: { type: "DateTime", desc: "Grade Start Date" }
  expose :ends_at, documentation: { type: "DateTime", desc: "Grade End Date" }
  expose :created_at, documentation: { type: "DateTime", desc: "Grade Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Grade Updated At" }
end
