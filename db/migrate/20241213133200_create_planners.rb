class CreatePlanners < ActiveRecord::Migration[6.1]
  def change
    create_table :planners do |t|
      t.date :date

      t.timestamps
    end
  end
end
