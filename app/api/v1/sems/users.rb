require "authentication_helpers"
class Api::V1::Sems::Users < Grape::API

  helpers AuthenticationHelpers

  resource :users do
    resource :instructors do
      desc "Get all instructors"
      get do
        instructors = Instructor.includes(:user).all
        present instructors, with: V1::Entities::Instructor
      end


      desc "Get current instructor courses"
      get "courses" do
        authorize_instructor!
        instructor = Instructor.find_by(user_id: Current.user.id)
        instructor_courses = CourseInstructor.where(instructor_id: Current.user.id)
        present instructor_courses, with: V1::Entities::InstructorCourse
      end

      desc "Get instructor by id"
      params do
        requires :id, type: Integer
      end
      get ":id" do
        instructor = Instructor.find_by(id: params[:id])
        if instructor
          present instructor, with: V1::Entities::Instructor
        else
          error!({ error: "Instructor not found" }, 404)
        end
      end

      desc "Create instructor"
      params do
        requires :email, type: String
        requires :password, type: String
        requires :name, type: String
        requires :department_id, type: Integer
        requires :year_of_exp, type: Integer
      end
      post do
        authorize_admin!

        if User.find_by(email: params[:email])
          error!({ error: "Email already exists" }, 400)
        end

        instructor = User.new.create_instructor(params)
        if instructor.is_a?(User)
          present instructor.instructor, with: V1::Entities::Instructor
        else
          error!(instructor.errors.full_messages, 400)
        end
      end

      desc "Update instructor"
      params do
        requires :id, type: Integer
        optional :email, type: String
        optional :name, type: String
        optional :department_id, type: Integer
        optional :year_of_exp, type: Integer
        optional :password, type: String
      end
      put ":id" do
        authorize_admin!
        instructor = User.new.update_instructor(params)
        if instructor
          instructor
        else
          error!(instructor.errors.full_messages, 400)
        end
      end

      route_param :instructor_id do
        before do
          @instructor = User.find_by(id: params[:instructor_id])
          error!({ error: "Instructor not found" }, 404) unless @instructor
        end

        resource :courses do
          desc "Get all courses for an instructor"
          get do
            present @instructor.courses, with: V1::Entities::Course
          end
        end

        # Teacher can see all the students assigned to him
        resource :assigned_courses do
          desc "Get all assigned courses to a student by an instructor"
          get do
            courses = AssignedCourse.where(assigned_by_instructor_id: @instructor.id)
            present courses, with: V1::Entities::AssignedCourse
          end
        end
      end

    end


    resource :students do

      desc "Get all students"
      get do
        students = Student.includes(:user).all
        present students, with: V1::Entities::Student
      end

      desc "Get all courses for a student"
      get "courses" do
        authorize_student!
        student = Student.find_by(user_id: Current.user.id)
        semester = Semester.find_by(id: student.semester_id)
        present semester.courses, with: V1::Entities::Course
      end

      desc "Get all courses for a student assigned by an instructor"
      get "assigned_courses" do
        authorize_student!
        assigned_courses = AssignedCourse.where(student_id: Current.user.id)
        present assigned_courses, with: V1::Entities::AssignedCourse
      end

      desc "Get student by id"
      params do
        requires :id, type: Integer
      end
      get ":id" do
        student = Student.find_by(user_id: params[:id])

        if student
          present student, with: V1::Entities::Student
        else
          error!({ error: "Student not found" }, 404)
        end
      end

      desc "Create student"
      params do
        requires :name, type: String
        requires :email, type: String
        requires :password, type: String
        requires :semester_id, type: Integer
        requires :department_id, type: Integer
      end
      post do
        authorize_admin!

        if User.find_by(email: params[:email])
          error!({ error: "Email already exists" }, 400)
        end

        student = User.new.create_student(params)
        if student.is_a?(User)
          present Student.find_by(user_id: student.id), with: V1::Entities::Student
        else
          if student.errors.full_messages.include?("Department not found")
            error!({ error: "Department not found" }, 400)
          else
            error!(student.errors.full_messages, 400)
          end
        end
      end

      desc "Update student"
      params do
        requires :id, type: Integer
        optional :email, type: String
        optional :name, type: String
        optional :department_id, type: Integer
        optional :year_of_study, type: Integer
      end
      put ":id" do
        authorize_admin!
        student = User.new.update_student(params)
        if student
          student
        else
          error!(student.errors.full_messages, 400)
        end
      end

      route_param :student_id do
        before do
          @student = User.find_by(id: params[:student_id])
          error!({ error: "Student not found" }, 404) unless @student
        end

        resource :enrollments do
          desc "Get all enrollments for a student"
          get do
            semester = Semester.find_by(id: @student.student.semester_id)
            present semester.courses, with: V1::Entities::Course
          end
        end

        resource :assigned_courses do
          desc "Get all assigned courses for a student"
          get do
            present @student.assigned_courses, with: V1::Entities::Course
          end
        end
      end
    end

  end

end
