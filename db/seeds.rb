# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create email: 'ryannnort@gmail.com', role: :admin
#User.create email: 'mpm1@ualberta.ca', role: :admin
#User.create email: 'ranaweer@ualberta.ca', role: :admin

# metadata = Metadata.create name: 'Story'
# MetadataField.create metadata: metadata, label: 'Name'

# @schema = File.read(File.join(Rails.root, 'example-schemas', 'story.xml'))
# Schema.create name: 'Story', xml_content: @schema

# set = MetadataSet.new name: 'story'

# field1 = MetadataField.create label: 'Field 1', order: 0
# field2 = MetadataField.create label: 'Field 2', order: 1

# set.metadata_fields << field1
# set.metadata_fields << field2

# set.save

# item1 = Item.new name: 'Item 1'
# item1.metadata_sets << set
# item1.save

# MetadataValue.create value: "value 1", item: item1, metadata_field: field1
# MetadataValue.create value: "value 2", item: item1, metadata_field: field2


# item2 = Item.new name: 'Item 2'
# item2.metadata_sets << set
# item2.save

# MetadataValue.create value: "value 3", item: item2, metadata_field: field1
# MetadataValue.create value: "value 4", item: item2, metadata_field: field2
