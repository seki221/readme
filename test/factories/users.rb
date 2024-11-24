FactoryBot.define do
  factory :user do
    nickname { "TestUser#{SecureRandom.hex(3)}" }  # ユニークなnicknameを生成
    email { "test_#{SecureRandom.hex(3)}@example.com" }  # ユニークなemailを生成
    password { "password" }
  end
end
