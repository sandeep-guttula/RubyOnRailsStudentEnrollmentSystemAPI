class V1::Entities::User < Grape::Entity
  expose :id, documentation: { type: "Integer", desc: "User ID" }
  expose :name, documentation: { type: "String", desc: "User Name" }
  expose :email, documentation: { type: "String", desc: "User Email" }
  expose :role, documentation: { type: "String", desc: "User Role" }
end
