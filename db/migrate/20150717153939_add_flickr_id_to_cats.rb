class AddFlickrIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :flickr_id, :integer, :limit => 8
    add_index :cats, :flickr_id
  end
end
