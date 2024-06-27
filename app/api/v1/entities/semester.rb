class V1::Entities::Semester < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Semester ID" }
  expose :name, documentation: { type: "String", desc: "Semester Title" }
  expose :start_date, documentation: { type: "Date", desc: "Semester Start Date" }
  expose :end_date, documentation: { type: "Date", desc: "Semester End Date" }
  expose :created_at, documentation: { type: "DateTime", desc: "Semester Created At" }
  expose :updated_at, documentation: { type: "DateTime", desc: "Semester Updated At" }
end
