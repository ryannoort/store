class FieldsCreatePrimaryKey < ActiveRecord::Migration[5.0]
  def change
	execute "ALTER TABLE fields ADD PRIMARY KEY(name, form_id);"
  end
end
