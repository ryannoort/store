class CreateJoinTableItemCollection < ActiveRecord::Migration[5.0]
  def change
      create_table :items_collections, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :collection, index: true
    end
  end
end
