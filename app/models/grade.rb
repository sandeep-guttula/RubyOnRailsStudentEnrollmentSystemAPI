class Grade < ApplicationRecord

  def create_grade(params)
    grade = Grade.new(
      grade: params[:grade],
      start_from: params[:start_from],
      ends_at: params[:ends_at],
    )
    if grade.save
      grade
    else
      grade.errors.full_messages
    end
  end

  def update_grade(params)
    grade = Grade.find_by(id: params[:id])
    return "Grade not found" unless grade

    if grade.update(params)
      grade
    else
      grade.errors.full_messages
    end
  end

  def delete_grade(params)
    grade = Grade.find_by(id: params[:id])
    return "Grade not found" unless grade

    if grade.destroy
      grade
    else
      grade.errors.full_messages
    end
  end

end
