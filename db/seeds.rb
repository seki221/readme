require 'factory_bot_rails'

# ユーザーを作成
puts 'start create users ...'
users = FactoryBot.create_list(:user, 1)
puts 'finish create users ...'

# スケジュールを作成
puts 'start create schedules ...'
schedules = 3.times.map do
  FactoryBot.create(:schedule, user: users.sample, image_url: "https://via.placeholder.com/250*150")
end
puts 'finish create schedules ...'
