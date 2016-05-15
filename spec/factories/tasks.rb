FactoryGirl.define do
  factory :task do
    name { Faker::App.name }
    description { Faker::Lorem.sentences(1) }
    user
    project
    association :executor, factory: :user
  end
end
