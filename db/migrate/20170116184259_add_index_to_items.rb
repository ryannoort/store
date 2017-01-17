class AddIndexToItems < ActiveRecord::Migration[5.0]
  def change
  	add_index :items, :location, using: :gist
  end
end
