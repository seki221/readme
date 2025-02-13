# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    body { 'MyText' }
    rating { 1 }
  end
end
