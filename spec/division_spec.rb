require 'spec_helper'

describe Division do
  it 'is initialized as an instance of Division' do
    new_division = Division.create(:name => "Logistics")
    new_division.name.should eq "Logistics"
    new_division.should be_an_instance_of Division
  end

  it { should have_many :employees }
end
