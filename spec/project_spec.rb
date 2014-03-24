require 'spec_helper'

describe Project do
  it { should have_many :employees }
  it { should have_many :contributions }
  it { should belong_to :division }
end
