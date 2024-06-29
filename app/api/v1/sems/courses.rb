require "pagination_helpers"
require "pagy"
require "pagy/extras/metadata"
require "authentication_helpers"
class Api::V1::Sems::Courses < Grape::API

  include Pagy::Backend
  include AuthenticationHelpers

  helpers do
    include Pagy::Backend
    def course_params
      ActionController::Parameters.new(params).permit(:title, :description, :capacity, :self_enroll_allowed, :department_id)
    end

    def course_prerequisite_params
      ActionController::Parameters.new(params).permit(:prerequisite_course_id)
    end

  end

  resource :courses do

    desc "Get all courses"
    params do
      optional :page, type: Integer, default: 1
      optional :items, type: Integer, default: 5
    end
    get do
      pagy, records = pagy(Course.all, items: params[:items], page: params[:page])
      present records, with: V1::Entities::Course
    end

    desc "Get course by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      course = Course.find_by(id: params[:id])
      if course
        present course, with: V1::Entities::Course
      else
        error!({ error: "Course not found" }, 404)
      end
    end

    desc "Create course"
    params do
      requires :title, type: String
      requires :description, type: String
      requires :capacity, type: Integer
      requires :self_enroll_allowed, type: Boolean
      requires :department_id, type: Integer
    end
    post do
      authorize_admin!
      course = Course.new(course_params)
      if course.save
        present course, with: V1::Entities::Course
      else
        error!({ error: course.errors.full_messages }, 400)
      end
    end

    desc "Update course"
    params do
      requires :id, type: Integer
      optional :title, type: String
      optional :description, type: String
      optional :capacity, type: Integer
      optional :self_enroll_allowed, type: Boolean
      optional :department_id, type: Integer
    end
    put ":id" do
      authorize_admin!
      course = Course.new.update_course(params)
    end

    desc "Delete course"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      authorize_admin!
      course = Course.new.delete_course(id: params[:id])
    end

    route_param :course_id do
      before do
        @course = Course.find_by(id: params[:course_id])
        error!({ error: "Course not found" }, 404) unless @course
      end
      resource :prerequisites do

        desc "Get all prerequisites for a course"
        get do
          prerequisites = @course.course_prerequisites.includes(:course, :prerequisite_course)
          present @course.prerequisite_courses, with: V1::Entities::Course
        end

        desc "Add prerequisite to a course"
        params do
          requires :prerequisite_course_id, type: Integer
        end
        post do
          course_prerequisite = CoursePrerequisite.new.create_course_prerequisite(course_id: @course.id, prerequisite_course_id: params[:prerequisite_course_id])
          if course_prerequisite.is_a?(CoursePrerequisite)
            present course_prerequisite, with: V1::Entities::CoursePrerequisite
          else
            error!({ error: course_prerequisite[:error] }, 400)
          end
        end

        desc "Remove prerequisite from a course"
        params do
          requires :id, type: Integer
        end
        delete ":id" do
          course_prerequisite = CoursePrerequisite.new.delete_course_prerequisite(id: params[:id])
          course_prerequisite
        end
      end

      # This route is for assigning instructors to a course. Accessible only by the admin only.
      resource :instructors do

        desc "Get all instructors for a course"
        get do
          instructors = @course.instructors
          present instructors, with: V1::Entities::User
        end

        desc "Add instructor to a course"
        params do
          requires :instructor_id, type: Integer
        end
        post do
          authorize_admin!
          course_instructor = CourseInstructor.new.add_instructor_to_course(course_id: @course.id, instructor_id: params[:instructor_id])
          if course_instructor.is_a?(CourseInstructor)
            present course_instructor, with: V1::Entities::CourseInstructor
          else
            error!({ error: course_instructor[:error] }, 400)
          end
        end

        desc "Remove instructor from a course"
        params do
          requires :instructor_id, type: Integer
        end
        delete do
          authorize_admin!
          course_instructor = CourseInstructor.new.remove_instructor_from_course(course_id: @course.id, instructor_id: params[:instructor_id])
          course_instructor
        end
      end

      # This route is for assigning a course to a student by an instructor, can be accessed by the instructor only
      resource :assign do
        desc "Assign course to the student"
        params do
          requires :student_id, type: Integer
        end
        post do
          authorize_instructor!
          assigned_course = AssignedCourse.new.assign_course_to_student(course_id: @course.id, student_id: params[:student_id])
          if assigned_course.is_a?(AssignedCourse)
            present assigned_course, with: V1::Entities::AssignedCourse
          else
            error!({ error: assigned_course[:error] }, 400)
          end
        end
      end

      resource :tests do

        desc "Get all tests for a course"
        get do
          tests = @course.tests
          present tests, with: V1::Entities::Test
        end

        desc "Create test for a course"
        params do
          requires :name, type: String
          requires :description, type: String
          requires :max_score, type: Integer
          requires :semester_id, type: Integer
        end
        post do
          authorize_instructor!
          test = Test.new.create_test(params)
          if test.is_a?(Test)
            present test, with: V1::Entities::Test
          else
            error!({ error: test[:error] }, 400)
          end
        end

        route_param :test_id do
          before do
            @test = Test.find_by(id: params[:test_id])
            error!({ error: "Test not found" }, 404) unless @test
          end
          resource :questions do
            desc "Get all questions for a test"
            get do
              questions = @test.test_questions
              present questions, with: V1::Entities::Question
            end

            desc "Add question to a test"
            params do
              requires :question, type: String
            end
            post do
              authorize_instructor!
              question = TestQuestion.new.create_question(@test.id, params[:question], @course.id)
              if question.is_a?(TestQuestion)
                present question, with: V1::Entities::Question
              else
                error!({ error: question[:error] }, 400)
              end
            end

            desc "Update question"
            params do
              requires :id, type: Integer
              requires :question, type: String
            end
            put ":id" do
              authorize_instructor!
              question = TestQuestion.find_by(id: params[:id])
              if question
                if question.update(question: params[:question])
                  present question, with: V1::Entities::Question
                else
                  error!({ error: question.errors.full_messages }, 400)
                end
              else
                error!({ error: "Question not found" }, 404)
              end
            end

            desc "Delete question"
            params do
              requires :id, type: Integer
            end
            delete ":id" do
              authorize_instructor!
              TestQuestion.new.delete_question(params[:id])
            end
          end
        end
      end
    end
  end
end
