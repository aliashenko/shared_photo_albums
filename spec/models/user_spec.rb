require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many(:albums).class_name(Album).with_foreign_key(:owner_id).dependent(:destroy) }
  it { should have_many(:album_viewers) }
  it { should have_many(:shared_albums).class_name(Album).through(:album_viewers) }
end
