require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
class Api::V1::Sems::Students < Grape::API

  include Pagy::Backend

  helpers do
    include Pagy::Backend
    def student_params
      ActionController::Parameters.new(params).permit(:name, :email, :password, :department_id, :year_of_study)
    end
  end

  resource :students do

    desc "Get all students"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(Student.all, items: params[:items], page: params[:page])
      present records, with: V1::Entities::Student
    end

    desc "Get student by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      student = Student.find_by(id: params[:id])
      if student
        present student, with: V1::Entities::Student
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    desc "Create student"
    params do
      requires :name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :department_id, type: Integer
      requires :year_of_study, type: Integer
    end
    post do
      student = User.new.create_student(params)
      if student.is_a?(User)
        present student, with: V1::Entities::User
      else
        error!(student.errors.full_messages, 400)
      end
    end

    desc "Update student"
    params do
      requires :id, type: Integer
      optional :email, type: String
      optional :name, type: String
      optional :department_id, type: Integer
      optional :year_of_study, type: Integer
      optional :password, type: String
    end
    put ":id" do
      student = User.new.update_student(params)
      if student
        present student
      else
        error!(student.errors.full_messages, 400)
      end
    end

  end
end
