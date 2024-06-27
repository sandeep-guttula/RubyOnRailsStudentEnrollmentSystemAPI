class V1::Entities::Test < Grape::Entity
  expose :id
  expose :name
  expose :description
  expose :max_score
  expose :course_id
  expose :semester_id
  expose :instructor_id
  expose :created_at
  expose :updated_at
end
