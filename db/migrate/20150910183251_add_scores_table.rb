class AddScoresTable < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :player_name, null: false
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.timestamps null: false
    end
  end
end
