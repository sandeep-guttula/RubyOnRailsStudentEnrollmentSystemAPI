require "authentication_helpers"
class Api < Grape::API

  helpers AuthenticationHelpers

  format :json
  prefix :api

  mount Api::V1::Sems::Auth

  before do
    authenticate!
  end
  mount Api::V1::Sems::Users
  mount Api::V1::Sems::Departments
  mount Api::V1::Sems::Courses
  mount Api::V1::Sems::Semesters
  mount Api::V1::Sems::AcademicPrograms
  mount Api::V1::Sems::Grades
  mount Api::V1::Sems::Tests
end

