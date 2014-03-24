class Employee < ActiveRecord::Base
 belongs_to :division
 has_many :project_employees
 has_many :projects, :through => :project_employees


end
