require 'rails_helper'

RSpec.describe Album, :type => :model do
  it { should belong_to(:owner).class_name(User) }
  it { should have_many :photos }

  it { should validate_presence_of :name }
end
