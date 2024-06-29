# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.create(name: "Admin", email: "admin01@admin.com", password: "123456789", password_confirmation: "123456789", role: "admin")
# User.create(name: "Admin 02", email: "admin02@admin.com", password: "123456789", password_confirmation: "123456789", role: "admin")
#
#
# departments_data = [
#   { name: 'Computer Science', description: 'Department of Computer Science' },
#   { name: 'Electrical Engineering', description: 'Department of Electrical Engineering' },
#   { name: 'Mechanical Engineering', description: 'Department of Mechanical Engineering' },
#   { name: 'Civil Engineering', description: 'Department of Civil Engineering' },
#   { name: 'Biology', description: 'Department of Biology' },
#   { name: 'Chemistry', description: 'Department of Chemistry' },
#   { name: 'Physics', description: 'Department of Physics' },
#   { name: 'Mathematics', description: 'Department of Mathematics' },
#   { name: 'Business Administration', description: 'Department of Business Administration' },
#   { name: 'Psychology', description: 'Department of Psychology' }
# ]
#
# departments_data.each do |dept_data|
#   Department.create!(dept_data)
# end
#
#
# academic_programs = [
#   { name: 'BTech', semester_count: 8 },
#   { name: 'Diploma', semester_count: 6 },
#   { name: 'MTech', semester_count: 4 },
#   { name: 'BBA', semester_count: 8 },
#   { name: 'MBA', semester_count: 4 },
#   { name: 'PhD', semester_count: 6 },
#   { name: 'MS', semester_count: 4 },
#   { name: 'MA', semester_count: 4 },
#   { name: 'BSc', semester_count: 8 },
#   { name: 'MSc', semester_count: 4 }
# ]
#
# academic_programs.each do |program|
#   AcademicProgram.create!(name: program[:name], semester_count: program[:semester_count])
# end
#
#
# start_date = Date.new(2024, 8, 20)
# programs = AcademicProgram.all
#
# programs.each do |program|
#   program.semester_count.times do |i|
#     Semester.create!(
#       name: "Semester #{i + 1}",
#       start_date: start_date,
#       end_date: start_date + 4.months - 5.days,
#       academic_program_id: program.id
#     )
#     start_date += 4.months
#   end
# end

# courses = [
#   { title: 'Introduction to Computer Science', description: 'Basics of Computer Science', capacity: 30, self_enroll_allowed: true, department_id: 1 },
#   { title: 'Data Structures and Algorithms', description: 'In-depth study of data structures and algorithms', capacity: 35, self_enroll_allowed: true, department_id: 1 },
#   { title: 'Operating Systems', description: 'Introduction to Operating Systems', capacity: 30, self_enroll_allowed: true, department_id: 1 },
#   { title: 'Circuit Analysis', description: 'Fundamentals of Electrical Circuits', capacity: 25, self_enroll_allowed: true, department_id: 2 },
#   { title: 'Digital Systems Design', description: 'Design of digital systems', capacity: 25, self_enroll_allowed: true, department_id: 2 },
#   { title: 'Thermodynamics', description: 'Introduction to Thermodynamics', capacity: 20, self_enroll_allowed: false, department_id: 3 },
#   { title: 'Fluid Mechanics', description: 'Study of fluid mechanics', capacity: 20, self_enroll_allowed: true, department_id: 3 },
#   { title: 'Structural Analysis', description: 'Analysis of Structures', capacity: 25, self_enroll_allowed: true, department_id: 4 },
#   { title: 'Construction Materials', description: 'Study of materials used in construction', capacity: 25, self_enroll_allowed: true, department_id: 4 },
#   { title: 'General Biology', description: 'Fundamentals of Biology', capacity: 40, self_enroll_allowed: true, department_id: 5 },
#   { title: 'Genetics', description: 'Introduction to Genetics', capacity: 40, self_enroll_allowed: true, department_id: 5 },
#   { title: 'General Chemistry', description: 'Basics of Chemistry', capacity: 35, self_enroll_allowed: true, department_id: 6 },
#   { title: 'Organic Chemistry', description: 'Study of Organic Chemistry', capacity: 35, self_enroll_allowed: true, department_id: 6 },
#   { title: 'General Physics', description: 'Fundamentals of Physics', capacity: 30, self_enroll_allowed: true, department_id: 7 },
#   { title: 'Electromagnetism', description: 'Study of electromagnetism', capacity: 30, self_enroll_allowed: true, department_id: 7 },
#   { title: 'Calculus I', description: 'Introduction to Calculus', capacity: 30, self_enroll_allowed: true, department_id: 8 },
#   { title: 'Linear Algebra', description: 'Study of Linear Algebra', capacity: 30, self_enroll_allowed: true, department_id: 8 },
#   { title: 'Principles of Management', description: 'Basics of Management', capacity: 50, self_enroll_allowed: true, department_id: 9 },
#   { title: 'Marketing 101', description: 'Introduction to Marketing', capacity: 50, self_enroll_allowed: true, department_id: 9 },
#   { title: 'Introduction to Psychology', description: 'Basics of Psychology', capacity: 45, self_enroll_allowed: true, department_id: 10 },
#   { title: 'Developmental Psychology', description: 'Study of human development', capacity: 45, self_enroll_allowed: true, department_id: 10 },
#   { title: 'Abnormal Psychology', description: 'Study of abnormal behavior', capacity: 45, self_enroll_allowed: true, department_id: 10 }
# ]
#
# courses.each do |course|
#   Course.create!(course)
# end
#
#
#
# course_prerequisites = [
#   { course: Course.find_by(title: 'Data Structures and Algorithms'), prerequisite_course: Course.find_by(title: 'Introduction to Computer Science') },
#   { course: Course.find_by(title: 'Operating Systems'), prerequisite_course: Course.find_by(title: 'Data Structures and Algorithms') },
#   { course: Course.find_by(title: 'Digital Systems Design'), prerequisite_course: Course.find_by(title: 'Circuit Analysis') },
#   { course: Course.find_by(title: 'Fluid Mechanics'), prerequisite_course: Course.find_by(title: 'Thermodynamics') },
#   { course: Course.find_by(title: 'Genetics'), prerequisite_course: Course.find_by(title: 'General Biology') },
#   { course: Course.find_by(title: 'Organic Chemistry'), prerequisite_course: Course.find_by(title: 'General Chemistry') },
#   { course: Course.find_by(title: 'Electromagnetism'), prerequisite_course: Course.find_by(title: 'General Physics') },
#   { course: Course.find_by(title: 'Linear Algebra'), prerequisite_course: Course.find_by(title: 'Calculus I') },
#   { course: Course.find_by(title: 'Marketing 101'), prerequisite_course: Course.find_by(title: 'Principles of Management') },
#   { course: Course.find_by(title: 'Developmental Psychology'), prerequisite_course: Course.find_by(title: 'Introduction to Psychology') },
#   { course: Course.find_by(title: 'Abnormal Psychology'), prerequisite_course: Course.find_by(title: 'Introduction to Psychology') }
# ]
#
#
# course_prerequisites.each do |prerequisite|
#   CoursePrerequisite.create!(prerequisite)
# end


# course_instructors = [
#   { course_id: 1, instructor_id: 3 },
#   { course_id: 2, instructor_id: 4 },
#   { course_id: 3, instructor_id: 5 },
#   { course_id: 1, instructor_id: 4 },
#   { course_id: 2, instructor_id: 5 }
# ]
#
# course_instructors.each do |course_instructor|
#   CourseInstructor.create!(course_instructor)
# end
#
# puts "Seeded #{course_instructors.count} course instructors."

course_offerings = [
  { course_id: 1, semester_id: 1, department_id: 1 },
  { course_id: 2, semester_id: 1, department_id: 1 },
  { course_id: 3, semester_id: 1, department_id: 1 },
  { course_id: 4, semester_id: 2, department_id: 2 }
]

course_offerings.each do |course_offering|
  CourseOffering.create!(course_offering)
end

# grades = [
#   { grade: "B", start_from: 80, ends_at: 89 },
#   { grade: "C", start_from: 70, ends_at: 79 },
#   { grade: "D", start_from: 60, ends_at: 69 },
#   { grade: "F", start_from: 0, ends_at: 59 }
# ]
#
# grades.each do |grade|
#   Grade.create!(grade)
# end


# users = User.where(role: "student")
#
# users.each do |user|
#   user.destroy
# end


# AssignedTest.create!(test_id: 10, student_id: 4, is_attempted: false)
# AssignedTest.create!(test_id: 10, student_id: 5, is_attempted: false)
# AssignedTest.create!(test_id: 10, student_id: 6, is_attempted: false)
