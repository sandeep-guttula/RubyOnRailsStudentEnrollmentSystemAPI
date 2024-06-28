class V1::Entities::Question < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Question ID" }
  expose :question, documentation: { type: "String", desc: "Question" }
end
