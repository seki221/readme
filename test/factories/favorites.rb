# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    user { nil }
    scheduled { nil }
  end
end
