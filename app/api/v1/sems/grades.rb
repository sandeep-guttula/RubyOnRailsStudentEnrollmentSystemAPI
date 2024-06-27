class Api::V1::Sems::Grades < Grape::API

  resource :grades do

    # Get all grades
    desc "Get all grades"
    get do
      grades = Grade.all
      present grades, with: V1::Entities::Grade
    end

    # Get grade by id
    desc "Get grade by id"
    params do
      requires :id, type: Integer
    end
    get ":id" do
      grade = Grade.find_by(id: params[:id])
      if grade
        present grade, with: V1::Entities::Grade
      else
        error!({ error: "Grade not found" }, 404)
      end
    end

    # Create grade
    desc "Create grade"
    params do
      requires :grade, type: String
      requires :start_from, type: Integer
      requires :ends_at, type: Integer
    end
    post do
      grade = Grade.new.create_grade(params)
      if grade.is_a?(Grade)
        present grade, with: V1::Entities::Grade
      else
        error!(grade.errors.full_messages, 400)
      end
    end

    # Update grade
    desc "Update grade"
    params do
      requires :id, type: Integer
      optional :grade, type: String
      optional :start_from, type: Integer
      optional :ends_at, type: Integer
    end
    put ":id" do
      grade = Grade.new.update_grade(params)
      if grade
        present grade
      else
        error!(grade.errors.full_messages, 400)
      end
    end

    # Delete grade
    desc "Delete grade"
    params do
      requires :id, type: Integer
    end
    delete ":id" do
      grade = Grade.find_by(id: params[:id])
      if grade
        grade.destroy
        present grade
      else
        error!({ error: "Grade not found" }, 404)
      end
    end

  end

end
