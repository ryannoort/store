class AddHintToFields < ActiveRecord::Migration[5.0]
  def change
    add_column :fields, :hint, :string
  end
end
