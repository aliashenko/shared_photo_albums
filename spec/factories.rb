FactoryGirl.define do
  factory :user do
    name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
  end

  factory :album do
    name { |n| "Title ##{n}" }
    description { |n| "Description of #{n} post" }
    association :user
  end

  factory :photo do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/file.jpg')))
    association :album
  end

  factory :another_photo do
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/file_2.jpg')))
    association :album
  end
end
