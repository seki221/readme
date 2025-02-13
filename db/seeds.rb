# frozen_string_literal: true

require 'factory_bot_rails'

# ユーザーを作成
Rails.logger.info 'start create users ...'
users = FactoryBot.create_list(:user, 1)
Rails.logger.info 'finish create users ...'

# スケジュールを作成
Rails.logger.info 'start create schedules ...'
FactoryBot.create(:schedule, user: users.sample, image_url: 'https://via.placeholder.com/250*150')
Rails.logger.info 'finish create schedules ...'
