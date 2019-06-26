FactoryBot.define do

  factory :user do
    email { "johndoe@hotmail.com" }
    password { "example" }
  end

  factory :random_user, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(min_length = 6) }
  end

  factory :user_with_assignments do
    transient do
      assignments_count { 10 }
    end

    after(:create) do |user, evaluator|
      create_list(:assignments, evaluator.assignments_count, user: user)
    end
  end

  factory :task do
    description { "Example task" }
    completed { false }
    completed_date { nil }

    factory :task_with_assignments do
      transient do
        assignments_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:assignments, evaluator.assignments_count, task: task)
      end
    end
  end

end
