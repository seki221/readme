class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,:registerable,:recoverable,
          :rememberable,:validatable,:timeoutable,:confirmable,
          :omniauthable,omniauth_providers: [:google_oauth2]

  validates :nickname, presence: true, length: { minimum: 2 }, unless: :omniauth_provider?

  has_many :schedules, dependent: :destroy
  has_many :planners, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_schedules, through: :favorites, source: :schedule

  def own?(schedule)
    self.id == schedule.user_id
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
  

  # by guest_user
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.name_kana = "げすと"
      user.country_code = "JP"
      user.job = "サラリーマン"
      user.is_deleted = false
      #＊上記は一例です。
    end
  end

  # by oauth
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize 
      # provider, uid が一致しないが email が一致する既存ユーザーを探す
    if user.new_record? && (existing_user = find_by(email: auth.info.email))
      user = existing_user
      user.provider = auth.provider
      user.uid = auth.uid
    end

      # ユーザー情報の設定
    user.email = auth.info.email
    user.password ||= Devise.friendly_token[0, 20]
    # user.name = auth.info.name if user.name.blank?
    user.nickname = auth.info.name || "User#{SecureRandom.hex(4)}" # デフォルトのニックネーム
    user.skip_confirmation!
    user.save!
    user
  end

  # def self.new_with_session(params, session)
  #   provider = "google"
  #   super.tap do |user|
  #     if data = session["devise.#{ provider }_data"] && session["devise.#{ provider }_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  def self.new_with_session(params, session)
    provider = "google"
    super.tap do |user|
      if session_data = session["devise.#{provider}_data"]
        if raw_info = session_data["extra"]&.dig("raw_info")
          user.email = raw_info["email"] if user.email.blank?
        end
      end
    end
  end

  def omniauth_provider?
    provider.present?
  end

  # URL の :id の部分に id 以外を指定
  def to_param
    screen_name
  end

  private ###################################################################
    # 新規会員登録時および更新時にuser_idに重複が無いかをチェックした上で保存する
    def check_secure_id
      return if User.find_by(user_uid: self.user_uid) != nil
      # 初回設定時
      loop do
        break if User.find_by(user_uid: self.user_uid) == nil
        self.user_uid = SecureRandom.alphanumeric(20)
      end
    end

    # 新規会員登録時および更新時にscreen_idに重複が無いかをチェックした上で保存する
    def check_screen_id
      return if User.find_by(screen_name: self.screen_name) != nil
      loop do
        break if User.find_by(screen_name: self.screen_name) == nil
        self.screen_name = SecureRandom.alphanumeric
      end
    end
end
