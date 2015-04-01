require 'rails_helper'

RSpec.describe Album, :type => :model do
  it { should belong_to(:owner).class_name(User).with_foreign_key(:owner_id) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should have_many(:album_viewers) }
  it { should have_many(:viewers).class_name(User).through(:album_viewers).dependent(:destroy) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :owner_id }
end
