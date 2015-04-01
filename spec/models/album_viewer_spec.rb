require 'rails_helper'

RSpec.describe AlbumViewer, :type => :model do
  it { should belong_to(:viewer).class_name(User).with_foreign_key(:user_id) }
  it { should belong_to(:shared_album).class_name(Album).with_foreign_key(:album_id) }
end
