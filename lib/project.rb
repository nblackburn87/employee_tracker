class Project < ActiveRecord::Base
  has_many :contributions
  has_many :employees, through: :contributions
  belongs_to :division
end
