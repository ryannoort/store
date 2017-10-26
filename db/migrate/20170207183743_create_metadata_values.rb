class CreateMetadataValues < ActiveRecord::Migration[5.0]
  def change
    create_table :metadata_values do |t|
      t.string :value
      t.belongs_to :metadata_field
      t.belongs_to :entity
      t.timestamps
    end
  end
end
