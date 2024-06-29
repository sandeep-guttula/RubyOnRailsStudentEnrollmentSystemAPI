require "authentication_helpers"

class Api::V1::Sems::Tests < Grape::API

  include AuthenticationHelpers

  resource :assessments do
    resource :courses do
      desc "Get all courses"
      get do
        courses = Course.all
        present courses, with: V1::Entities::Course
      end

      route_param :course_id do

        before do
          @course = Course.find_by(id: params[:course_id])
          error!({ error: "Course not found" }, 404) unless @course
        end

        resource :tests do
          desc "Get all tests for a course"
          get do
            tests = @course.tests
            present tests, with: V1::Entities::Test, type: :full
          end

          desc "Get a test for a course"
          params do
            requires :test_id, type: Integer
          end
          get ":test_id" do
            test = @course.tests.find_by(id: params[:test_id])
            error!({ error: "Test not found" }, 404) unless test
            present test, with: V1::Entities::Test
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

              desc "Get a question for a test"
              params do
                requires :question_id, type: Integer
              end
              get ":question_id" do
                question = @test.test_questions.find_by(id: params[:question_id])
                error!({ error: "Question not found" }, 404) unless question
                present question, with: V1::Entities::Question
              end

              route_param :question_id do
                before do
                  @question = @test.test_questions.find_by(id: params[:question_id])
                  error!({ error: "Question not found" }, 404) unless @question
                end

                resource :answers do
                  get do
                    answers = @question.student_answers
                    present answers, with: V1::Entities::Answer
                  end

                  desc "Add an answer to a question"
                  params do
                    requires :answer, type: String
                  end
                  post do
                    authorize_student!
                    answer = StudentAnswer.new.create_answer(@test, @question, params[:answer])
                    present answer, with: V1::Entities::Answer
                  end
                end
              end
            end

            # Route to give score to a test update it assigned_test table
            resources :students do

              desc "Get all students for a test"
              get do
                students = @test.students
                present students, with: V1::Entities::Student
              end

              desc "Get a student for a test"
              params do
                requires :student_id, type: Integer
              end
              get ":student_id" do
                student = @test.students.find_by(id: params[:student_id])
                error!({ error: "Student not found" }, 404) unless student
                present student, with: V1::Entities::Student
              end

              route_param :student_id do
                before do
                  @student = Student.find_by(user_id: params[:student_id])
                  error!({ error: "Student not found" }, 404) unless @student
                end
                resource :grade do
                  desc "Give score to a student"
                  params do
                    requires :score, type: Integer
                  end
                  post do
                    authorize_instructor!

                    # check the department of the instructor and the department of the course
                    if @test.course.department_id != Current.user.instructor.department_id
                      error!({ error: "You are not authorized to give score to this student" }, 401)
                    end

                    assigned_test = AssignedTest.new.update_score(@test, @student, @course,params[:score])
                    present assigned_test, with: V1::Entities::AssignedTest
                  end
                end

                resources :answers do
                  desc "Get all answers for a student"
                  get do
                    # get all the student answers for a test
                    student_answers = @student.student_answers.where(test_question_id: @test.test_questions.pluck(:id))
                    present student_answers
                  end
                end

              end
            end
          end
        end
      end
    end
  end
end
