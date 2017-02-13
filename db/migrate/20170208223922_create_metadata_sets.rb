class CreateMetadataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :metadata_sets do |t|
			t.string :name    
      t.timestamps
    end
  end
end
