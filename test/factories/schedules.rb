FactoryBot.define do
  factory :schedule do
    association :user
    destination { "MyString" }
    start_at { "2024-11-21 10:24:05" }
    end_at { "2024-11-21 10:24:05" }
    cost { 1 }
    review { "MyText" }
    transportation { "MyString" }
    position { 1 }
  end
end
