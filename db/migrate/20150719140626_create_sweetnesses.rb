class CreateSweetnesses < ActiveRecord::Migration
  def change
    create_table :sweetnesses do |t|
      t.integer :cat_id
      t.integer :value

      t.timestamps null: false
    end
    add_index :sweetnesses, :cat_id
  end
end
