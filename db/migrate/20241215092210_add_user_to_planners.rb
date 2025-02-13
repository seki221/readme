# frozen_string_literal: true

class AddUserToPlanners < ActiveRecord::Migration[6.1]
  def change
    # 1. NULLを許可してuser_idを追加
    add_reference :planners, :user, null: true, foreign_key: true

    # 2. 既存のレコードにデフォルトのuser_idを設定
    default_user = User.first # 既存のUserから適当なレコードを選ぶ
    Planner.where(user_id: nil).update_all(user_id: default_user.id) if default_user

    # 3. user_idにNOT NULL制約を追加
    change_column_null :planners, :user_id, false
  end
end
