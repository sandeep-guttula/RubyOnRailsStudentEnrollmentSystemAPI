class V1::Entities::Test < Grape::Entity
  expose :id
  expose :name
  expose :description
  expose :max_score
  expose :course_id
  expose :semester, using: V1::Entities::Semester
  expose :instructor, using: V1::Entities::User
end
