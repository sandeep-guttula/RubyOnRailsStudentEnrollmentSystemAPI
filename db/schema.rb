# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_06_29_085227) do
  create_table "academic_programs", force: :cascade do |t|
    t.string "name"
    t.integer "semester_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assigned_courses", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.integer "assigned_by_instructor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_by_instructor_id"], name: "index_assigned_courses_on_assigned_by_instructor_id"
    t.index ["course_id"], name: "index_assigned_courses_on_course_id"
    t.index ["student_id"], name: "index_assigned_courses_on_student_id"
  end

  create_table "assigned_tests", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "student_id", null: false
    t.boolean "is_attempted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.index ["student_id"], name: "index_assigned_tests_on_student_id"
    t.index ["test_id", "student_id"], name: "index_assigned_tests_on_test_id_and_student_id", unique: true
    t.index ["test_id"], name: "index_assigned_tests_on_test_id"
  end

  create_table "course_instructors", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_instructors_on_course_id"
    t.index ["instructor_id"], name: "index_course_instructors_on_instructor_id"
  end

  create_table "course_offerings", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "semester_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["course_id"], name: "index_course_offerings_on_course_id"
    t.index ["semester_id"], name: "index_course_offerings_on_semester_id"
  end

  create_table "course_prerequisites", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "prerequisite_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_prerequisites_on_course_id"
    t.index ["prerequisite_course_id"], name: "index_course_prerequisites_on_prerequisite_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "capacity"
    t.boolean "self_enroll_allowed"
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "semester_id", null: false
    t.string "status"
    t.datetime "enrolled_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["semester_id"], name: "index_enrollments_on_semester_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "department_id", null: false
    t.integer "year_of_exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_instructors_on_department_id"
    t.index ["user_id"], name: "index_instructors_on_user_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "academic_program_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_program_id"], name: "index_semesters_on_academic_program_id"
  end

  create_table "student_answers", force: :cascade do |t|
    t.string "answer"
    t.integer "test_question_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_answers_on_student_id"
    t.index ["test_question_id"], name: "index_student_answers_on_test_question_id"
  end

  create_table "student_grades", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.string "final_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_grades_on_course_id"
    t.index ["student_id"], name: "index_student_grades_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "semester_id", null: false
    t.integer "user_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_students_on_department_id"
    t.index ["semester_id"], name: "index_students_on_semester_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "test_questions", force: :cascade do |t|
    t.integer "test_id", null: false
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_test_questions_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "course_id"
    t.integer "semester_id"
    t.integer "instructor_id"
    t.integer "max_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_tests_on_course_id"
    t.index ["instructor_id"], name: "index_tests_on_instructor_id"
    t.index ["semester_id"], name: "index_tests_on_semester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assigned_courses", "courses"
  add_foreign_key "assigned_courses", "users", column: "assigned_by_instructor_id"
  add_foreign_key "assigned_courses", "users", column: "student_id"
  add_foreign_key "assigned_tests", "tests"
  add_foreign_key "assigned_tests", "users", column: "student_id"
  add_foreign_key "course_instructors", "courses"
  add_foreign_key "course_instructors", "users", column: "instructor_id"
  add_foreign_key "course_offerings", "courses"
  add_foreign_key "course_offerings", "departments"
  add_foreign_key "course_offerings", "semesters"
  add_foreign_key "course_prerequisites", "courses"
  add_foreign_key "course_prerequisites", "courses", column: "prerequisite_course_id"
  add_foreign_key "courses", "departments"
  add_foreign_key "enrollments", "semesters"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "instructors", "departments"
  add_foreign_key "instructors", "users"
  add_foreign_key "semesters", "academic_programs"
  add_foreign_key "student_answers", "test_questions"
  add_foreign_key "student_answers", "users", column: "student_id"
  add_foreign_key "student_grades", "courses"
  add_foreign_key "student_grades", "users", column: "student_id"
  add_foreign_key "students", "departments"
  add_foreign_key "students", "semesters"
  add_foreign_key "students", "users"
  add_foreign_key "test_questions", "tests"
  add_foreign_key "tests", "courses"
  add_foreign_key "tests", "semesters"
  add_foreign_key "tests", "users", column: "instructor_id"
end
