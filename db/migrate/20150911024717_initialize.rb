class Initialize < ActiveRecord::Migration
  def change
    
    create_table "polls", force: :cascade do |t|
      t.boolean  "group_a"
      t.integer  "value"
      t.boolean  "live"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end
