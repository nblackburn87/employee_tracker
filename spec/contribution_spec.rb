require 'spec_helper'

describe Contribution  do
  it { should belong_to :employee }
  it { should belong_to :project }
end
