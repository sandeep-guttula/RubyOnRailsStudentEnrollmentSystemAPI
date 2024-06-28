class Department < ApplicationRecord
  has_many :instructors
  has_many :courses
  has_many :course_offerings
  has_many :semesters
  has_one :student

  validates :name, presence: true , uniqueness: true
  validates :description, presence: true
  def create_department(params)
    department = Department.new(name: params[:name], description: params[:description])
    if department.save
      department
    else
      { error: department.errors.full_messages }
    end
  end

  def update_department(params)
    department = Department.find_by(id: params[:id])
    return { error: "Department not found" } unless department

    if department.update(name: params[:name], code: params[:code])
      department
    else
      { error: department.errors.full_messages }
    end
  end

  def delete_department(params)
    department = Department.find_by(id: params[:id])
    return { error: "Department not found" } unless department

    if department.destroy
      { message: "Department removed successfully" }
    else
      { error: department.errors.full_messages }
    end
  end
end
