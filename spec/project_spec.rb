require 'spec_helper'

describe Project do
  it { should have_many :employees }
  it { should have_many :contributions }
end
