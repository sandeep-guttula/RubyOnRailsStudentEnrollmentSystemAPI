require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
require "authentication_helpers"
class Api::V1::Sems::Departments < Grape::API

  include Pagy::Backend
  include AuthenticationHelpers

  helpers do
    include Pagy::Backend
  end

  resource :departments do

    desc "Get all departments"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(Department.all, items: params[:items], page: params[:page])
      { departments: records, metadata: pagy }
    end

    desc "Get department by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
       Department.find(params[:id])
    end

    desc "Create department"
    params do
      requires :name, type: String
      requires :description, type: String
    end
    post do
      authorize_admin!
      department = Department.new.create_department(params)
      if department.is_a?(Department)
        present department, with: V1::Entities::Department
      else
        error!({ error: department.errors.full_messages }, 400)
      end
    end

    desc "Update department"
    params do
      requires :id, type: Integer
      requires :name, type: String
    end
    put ":id" do
      authorize_admin!
      department = Department.find(params[:id])
      if department.update(
        name: params[:name]
      )
        present department, with: V1::Entities::Department
      else
        error!({ error: department.errors.full_messages }, 400)
      end
    end

    desc "Delete department"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      authorize_admin!
      department = Department.find(params[:id])
      if department.destroy
        { message: "Department deleted successfully" }
      else
        error!({ error: department.errors.full_messages }, 400)
      end
    end

    route_param :id do

      before do
        @department = Department.find(params[:id])
        error!({ error: "Department not found" }, 404) unless @department
      end

      resource :courses do
        desc "Get all courses for department"
        params do
          optional :page, type: Integer, default: 1
          optional :items, type: Integer, default: 5
        end
        get do
          courses = @department.courses
          present courses, with: V1::Entities::Course
        end
      end
    end
  end
end
