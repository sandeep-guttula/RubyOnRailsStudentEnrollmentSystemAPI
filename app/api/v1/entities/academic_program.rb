class V1::Entities::AcademicProgram < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Academic Program ID" }
  expose :name, documentation: { type: "String", desc: "Academic Program Name" }
  expose :semester_count, documentation: { type: "Integer", desc: "Academic Program Description" }
end
