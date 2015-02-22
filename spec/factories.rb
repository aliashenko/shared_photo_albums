FactoryGirl.define do
  factory :user do
    first_name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
  end

  factory :album do
    name { |n| "Title ##{n}" }
    description { |n| "Description of #{n} post" }
    association :user
  end
end
