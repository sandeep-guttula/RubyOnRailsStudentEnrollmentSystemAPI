class Api::V1::Sems::Instructors < Grape::API
  resource :instructors do

    # Get all instructors
    desc "Get all instructors"
    get do
      instructors = Instructor.includes(:user).all
      present instructors, with: V1::Entities::Instructor
    end

    # Get instructor by id
    desc "Get teacher by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      instructor = Instructor.includes(:user).find_by(id: params[:id])
      if instructor
        present instructor, with: V1::Entities::Instructor
      else
        error!({ error: "Instructor not found" }, 404)
      end
    end

    # Create instructor
    desc "Create teacher"
    params do
      requires :email, type: String
      requires :password, type: String
      requires :name, type: String
      requires :department_id, type: Integer
      requires :year_of_exp, type: Integer
    end
    post do
      instructor = User.new.create_instructor(params)
      if instructor.is_a?(User)
        present instructor, with: V1::Entities::User
      else
        error!(instructor.errors.full_messages, 400)
      end
    end

    # TODO: Fix update instructor
    # Update instructor
    desc "Update teacher"
    params do
      requires :id, type: Integer
      optional :email, type: String
      optional :name, type: String
      optional :department_id, type: Integer
      optional :year_of_exp, type: Integer
      optional :password, type: String
    end
    put ":id" do
      instructor = User.new.update_instructor(params)
      if instructor
        present instructor
      else
        error!(instructor.errors.full_messages, 400)
      end
    end

    # Delete instructor
    desc "Delete teacher"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      instructor = User.new.delete_instructor(params)
      if instructor
        present instructor
      else
        error!(instructor.errors.full_messages, 400)
      end
    end
  end
end
