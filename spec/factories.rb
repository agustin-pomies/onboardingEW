FactoryBot.define do

  factory :user do
    email { "johndoe@hotmail.com" }
    password { "example" }
    assignments { [] }
  end

  factory :random_user, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(min_length = 6) }
    assignments { [] }
  end

  factory :task do
    description { "Example task" }
    completed { false }
    completed_date { nil }
    assignments { [] }
  end

  factory :assignment do
    ownership { false }
    user
    task
  end
end
