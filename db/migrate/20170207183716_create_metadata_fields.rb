class CreateMetadataFields < ActiveRecord::Migration[5.0]
  def change
    create_table :metadata_fields do |t|
      t.integer :field_type
      t.string :label
      t.string :hint
      t.string :default
      t.boolean :is_required
      t.integer :order
      t.belongs_to :metadata_set

      t.timestamps
    end
  end
end
