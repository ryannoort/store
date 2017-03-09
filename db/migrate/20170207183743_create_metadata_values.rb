class CreateMetadataValues < ActiveRecord::Migration[5.0]
  def change
    create_table :metadata_values do |t|
      t.string :value
      # t.belongs_to :item
      t.belongs_to :metadata_field
      t.references :valuable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
