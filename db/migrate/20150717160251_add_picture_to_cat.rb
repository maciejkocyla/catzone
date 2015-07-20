class AddPictureToCat < ActiveRecord::Migration
  def change
    add_column :cats, :picture, :string
  end
end
