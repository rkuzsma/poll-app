class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.boolean :group_a
      t.integer :value

      t.timestamps null: false
    end
  end
end
