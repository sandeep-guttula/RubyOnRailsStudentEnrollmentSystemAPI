require "authentication_helpers"

class Api::V1::Sems::Tests < Grape::API

  include AuthenticationHelpers

  resource :tests do

    desc "Get all tests of a student"
    get do
      authorize_student!
      student = Student.find_by(user_id: Current.user.id)
      tests = student.tests
      present tests, with: V1::Entities::Test
    end

    desc "Get a test"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      authorize_student!
      test = Test.find_by(id: params[:id])
      error!({ error: "Test not found" }, 404) unless test
      present test, with: V1::Entities::Test
    end

    route_param :test_id do
      before do
        @test = Test.find_by(id: params[:test_id])

        puts "Test: #{@test.inspect}  #{ params[:test_id] }"

        error!({ error: "Test not found" }, 404) unless @test
      end
      resource :questions do
        desc "Get all questions for a test"
        get do
          questions = @test.test_questions
          present questions
        end

        get ":question_id" do
          question = @test.test_questions.find_by(id: params[:question_id])
          error!({ error: "Question not found" }, 404) unless question
          present question
        end

        route_param :question_id do

          resource :answers do

            desc "Get all answers for a question"
            get do
              question = @test.test_questions.find_by(id: params[:question_id])
              error!({ error: "Question not found" }, 404) unless question
              answers = question.student_answers
              present answers
            end

            desc "Answer a question"
            params do
              requires :answer, type: String
            end

            post do

              if Current.user.role != User::STUDENT_ROLE
                error!({ error: "Only students can answer questions" }, 400)
              end

              question = @test.test_questions.find_by(id: params[:question_id])
              error!({ error: "Question not found" }, 404) unless question

              student = Student.find_by(user_id: Current.user.id)
              student_answer = question.student_answers.find_by(student_id: student.id)
              error!({ error: "You have already answered this question" }, 400) if student_answer

              student_answer = question.student_answers.create!(student_id: student.id, answer: params[:answer])
              if student_answer
                AssignedTest.find_by(test_id: @test.id, student_id: student.id).update!(is_attempted: true)
              end

              present student_answer
            end
          end

        end

      end



      # Route to give score to a test update it assigned_test table
      resources :students do
        route_param :student_id do
          before do
            @student = Student.find_by(id: params[:student_id])
            error!({ error: "Student not found" }, 404) unless @student
          end
          resource :score do
            desc "Give score to a student"
            params do
              requires :score, type: Integer
            end
            post do
              authorize_instructor!
              assigned_test = AssignedTest.find_by(test_id: @test.id, student_id: @student.id)
              error!({ error: "Student has not attempted this test" }, 400) unless assigned_test.is_attempted
              assigned_test.update!(score: params[:score])


              assigned_tests = @student.assigned_tests
                                       .includes(:test)
                                       .where(tests: { course_id: @test.course_id, semester_id: @test.semester_id })

              scored_tests = assigned_tests.reject { |at| at.score.nil? }

              if scored_tests.size == assigned_tests.size
                total_score = scored_tests.sum(&:score)
                test_count = scored_tests.size
                average_score = total_score.to_f / test_count

                StudentGrade.create!(
                  student_id: @student.id,
                  course_id: @test.course_id,
                  final_score: average_score
                )

                { message: "Student has completed the course with an average of #{average_score}" }
              else
                present assigned_tests
              end
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
