class CreateTransportations < ActiveRecord::Migration[6.1]
  def change
    create_table :transportations do |t|
      t.string :category
      t.references :schedule, null: false, foreign_key: true
      # ※いらない

      t.timestamps
    end
  end
end
