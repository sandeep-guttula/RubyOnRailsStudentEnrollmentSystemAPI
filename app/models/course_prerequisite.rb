class CoursePrerequisite < ApplicationRecord
  belongs_to :course, class_name: "Course"
  belongs_to :prerequisite_course, class_name: "Course"

  validates :course_id, presence: true
  validates :prerequisite_course_id, presence: true

  def create_course_prerequisite(params)
    course = Course.find_by(id: params[:course_id])
    return "Course not found" unless course

    prerequisite_course = Course.find_by(id: params[:prerequisite_course_id])
    return "Prerequisite course not found" unless prerequisite_course

    course_prerequisite = CoursePrerequisite.new(params)
    if course_prerequisite.save
      course_prerequisite
    else
      course_prerequisite.errors.full_messages
    end
  end

  def update_course_prerequisite(params)
    course_prerequisite = CoursePrerequisite.find_by(id: params[:id])
    return "Course prerequisite not found" unless course_prerequisite

    if course_prerequisite.update(params)
      course_prerequisite
    else
      course_prerequisite.errors.full_messages
    end
  end

  def delete_course_prerequisite(params)
    course_prerequisite = CoursePrerequisite.find_by(id: params[:id])
    return "Course prerequisite not found" unless course_prerequisite

    if course_prerequisite.destroy
      "Course prerequisite deleted successfully"
    else
      course_prerequisite.errors.full_messages
    end
  end
end
