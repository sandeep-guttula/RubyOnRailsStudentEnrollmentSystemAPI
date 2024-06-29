class StudentGrade < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "student_id"
  belongs_to :course
end



def create_grade(student_id, course_id, grade)
  student = User.find_by(id: student_id)
  return { error: "Student not found" } unless student

  course = Course.find_by(id: course_id)
  return { error: "Course not found" } unless course

  student_grade = StudentGrade.new(student_id: student_id, course_id: course_id, grade: grade)
  if student_grade.save
    student_grade
  else
    student_grade.errors
  end
end
