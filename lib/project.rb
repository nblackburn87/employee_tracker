class Project < ActiveRecord::Base
  has_many :project_employees
  has_many :employees, :through => :project_employees
end
