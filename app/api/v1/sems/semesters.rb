require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
class Api::V1::Sems::Semesters < Grape::API
  include Pagy::Backend

  helpers do
    include Pagy::Backend
    def semester_params
      ActionController::Parameters.new(params).permit(:name, :start_date, :end_date, :academic_program_id)
    end
  end

  resource :semesters do

    desc "Get all semesters"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(Semester.all, items: params[:items], page: params[:page])
      present records, with: V1::Entities::Semester
    end

    desc "Get semester by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      semester = Semester.find_by(id: params[:id])
      if semester
        present semester, with: V1::Entities::Semester
      else
        error!({ error: "Semester not found" }, 404)
      end
    end

    desc "Create semester"
    params do
      requires :name, type: String
      requires :start_date, type: Date
      requires :end_date, type: Date
      requires :academic_program_id, type: Integer
    end
    post do
      # check if academic program exists
      academic_program = AcademicProgram.find_by(id: params[:academic_program_id])
      error!({ error: "Academic Program not found" }, 404) unless academic_program

      semesters = academic_program.semesters
      if semesters.count >= academic_program.semester_count
        error!({ error: "Semester count exceeded for the academic program" }, 400)
      end

      semester = Semester.create!(semester_params)
      present semester, with: V1::Entities::Semester
    end

    desc "Update semester"
    params do
      requires :id, type: Integer
      optional :title, type: String
      optional :start_date, type: Date
      optional :end_date, type: Date
    end
    put ":id" do
      semester = Semester.find_by(id: params[:id])
      if semester
        if semester.update(semester_params)
          present semester, with: V1::Entities::Semester
        else
          error!({ error: semester.errors.full_messages }, 400)
        end
      else
        error!({ error: "Semester not found" }, 404)
      end
    end

    desc "Delete semester"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      semester = Semester.find_by(id: params[:id])
      if semester
        semester.destroy
        { message: "Semester deleted successfully" }
      else
        error!({ error: "Semester not found" }, 404)
      end
    end

    route_param :semester_id do
      before do
        @semester = Semester.find_by(id: params[:semester_id])
        error!({ error: "Semester not found" }, 404) unless @semester
      end

      resource :courses do
        desc "Get all courses for a semester"
        get do
          present @semester.courses, with: V1::Entities::Course
        end

        desc "Create course for a semester"
        params do
          requires :course_id, type: Integer
          requires :department_id, type: Integer
        end
        post do

          if @semester.courses.find_by(id: params[:course_id])
            error!({ error: "Course already exists in semester" }, 400)
          end

          if Department.find_by(id: params[:department_id]).nil?
            error!({ error: "Department not found" }, 404)
          end

          course = Course.find_by(id: params[:course_id])
          if course
            course_offering = CourseOffering.create!(params.merge(semester_id: @semester.id))
            present course_offering, with: V1::Entities::CourseOffering
          else
            error!({ error: "Course not found" }, 404)
          end
        end

        desc "Delete course for a semester"
        params do
          requires :course_id, type: Integer
        end
        delete ":course_id" do
          course = @semester.courses.find_by(id: params[:course_id])
          if course
            @semester.courses.delete(course)
            { message: "Course deleted successfully" }
          else
            error!({ error: "Course not found" }, 404)
          end
        end

      end

    end

  end
end
