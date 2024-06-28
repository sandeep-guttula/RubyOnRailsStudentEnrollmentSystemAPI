require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
require "authentication_helpers"
class Api::V1::Sems::AcademicPrograms < Grape::API

  helpers AuthenticationHelpers
  include Pagy::Backend

  helpers do
    include Pagy::Backend

  end

  resource :academic_programs do

    desc "Get all academic programs"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(AcademicProgram.all, items: params[:items], page: params[:page])
      present records, with: V1::Entities::AcademicProgram
    end

    desc "Get academic program by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      academic_program = AcademicProgram.find_by(id: params[:id])
      if academic_program
        present academic_program, with: V1::Entities::AcademicProgram
      else
        error!({ error: "Academic Program not found" }, 404)
      end
    end

    before do
      authorize_admin!
    end

    desc "Create academic program"
    params do
      requires :name, type: String
      requires :semester_count, type: Integer
    end
    post do
      declared_params = declared(params, include_missing: false)
      academic_program = AcademicProgram.create!(declared_params)
      present academic_program, with: V1::Entities::AcademicProgram
    end

    desc "Update academic program"
    params do
      requires :id, type: Integer
      optional :title, type: String
      optional :description, type: String
      optional :department_id, type: Integer
    end
    put ":id" do
      academic_program = AcademicProgram.find_by(id: params[:id])
      error!({ error: "Academic Program not found" }, 404) unless academic_program

      if academic_program
        academic_program.update!(params)
        present academic_program, with: V1::Entities::AcademicProgram
      else
        error!({ error: "Unable to update academic program" }, 402)
      end
    end

    desc "Delete academic program"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      academic_program = AcademicProgram.find_by(id: params[:id])
      error!({ error: "Academic Program not found" }, 404) unless academic_program
      if academic_program.destroy
        { success: "Academic Program deleted" }
      else
        error!({ error: "Unable to delete academic program" }, 402)
      end
    end
  end
end
