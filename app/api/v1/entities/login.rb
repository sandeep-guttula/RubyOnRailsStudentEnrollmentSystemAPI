class V1::Entities::Login < Grape::Entity
  expose :token
  expose :user, using: V1::Entities::User, as: :user
end
