require 'spec_helper'

describe Employee do
  it 'initializes the Employee class' do
    new_employee = Employee.create(:name => "David")
    new_employee.name.should eq "David"
    new_employee.should be_an_instance_of Employee
  end

  it { should belong_to :division }
end
