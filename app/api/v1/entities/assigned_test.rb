class V1::Entities::AssignedTest < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "Assigned Test ID" }
  expose :test_id, documentation: { type: "Integer", desc: "Test ID" }
  expose :student_id, documentation: { type: "Integer", desc: "Student ID" }
  expose :score, documentation: { type: "Integer", desc: "Score" }
  expose :is_attempted, documentation: { type: "Boolean", desc: "Is Attempted" }
end
