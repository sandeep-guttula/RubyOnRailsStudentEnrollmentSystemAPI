require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
require "authentication_helpers"

class Api::V1::Sems::CourseOfferings < Grape::API
  include Pagy::Backend
  include AuthenticationHelpers

  helpers do
    include Pagy::Backend
    def course_offering_params
      ActionController::Parameters.new(params).permit(:course_id, :semester_id, :instructor_id, :department_id)
    end
  end

  resource :offerings do

    before do
      authorize_admin!
    end

    desc "Get all course offerings"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(CourseOffering.all, items: params[:items], page: params[:page])
      present records, with: V1::Entities::CourseOffering
    end

    desc "Get course offering by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      course_offering = CourseOffering.find_by(id: params[:id])
      if course_offering
        present course_offering, with: V1::Entities::CourseOffering
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    desc "Create course offering"
    params do
      requires :course_id, type: Integer
      requires :semester_id, type: Integer
      requires :instructor_id, type: Integer
      requires :department_id, type: Integer
    end
    post do
      course_offering = CourseOffering.new(course_offering_params)
      if course_offering.save
        present course_offering, with: V1::Entities::CourseOffering
      else
        error!({ error: course_offering.errors.full_messages }, 400)
      end
    end

    desc "Update course offering"
    params do
      requires :id, type: Integer
      optional :course_id, type: Integer
      optional :semester_id, type: Integer
      optional :instructor_id, type: Integer
      optional :department_id, type: Integer
    end
    put ":id" do
      course_offering = CourseOffering.find_by(id: params[:id])
      if course_offering.update(course_offering_params)
        present course_offering
      else
        error!({ error: course_offering.errors.full_messages }, 400)
      end
    end

    desc "Delete course offering"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      course_offering = CourseOffering.find_by(id: params[:id])
      if course_offering.destroy
        { message: "Course Offering removed successfully" }
      else
        error!(course_offering.errors.full_messages, 400)
      end
    end
  end

end
