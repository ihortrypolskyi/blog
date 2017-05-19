FactoryGirl.define do
  factory :user do
    first_name Faker::Name.unique.first_name
    last_name Faker::Name.unique.last_name
    email Faker::Internet.unique.email
    password_digest Faker::Internet.password(min_length = 3, max_length = 30)

    # /sequence(:last_name) { |n| "#{Faker::Name.unique.last_name}#{n}" }
    # sequence(:first_name) { |n| "#{Faker::Name.first_name}#{n}" }
    # sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
  end
end
