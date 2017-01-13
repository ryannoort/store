# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create email: 'orodrigu@ualberta.ca', role: :admin
User.create email: 'mpm1@ualberta.ca', role: :admin
User.create email: 'ranaweer@ualberta.ca', role: :admin

@schema = File.read(File.join(Rails.root, 'example-schemas', 'story.xml'))
Schema.create name: 'Story', xml_content: @schema