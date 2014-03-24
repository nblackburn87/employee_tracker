class Project_employees < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project
end
