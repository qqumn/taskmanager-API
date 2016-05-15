FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(1) }
    user
    association :commentable, factory: :task
  end
end
