require 'spec_helper'

describe Project_employees do
  it { should belong_to :employee}

  it {should belong_to :project}
end
