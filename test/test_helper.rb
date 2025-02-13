# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods # FactoryBot のメソッドを短縮形で使えるようにする
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # データベースのトランザクション管理（適用するかはプロジェクトの構成による）
  config.use_transactional_fixtures = true

  # RSpecの書き方による設定
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # 必要に応じて、before/after コールバックなども追加できます。
end
