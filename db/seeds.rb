# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
list = ['tag 1', 'tag 2', 'tag 3']

list.each do |tag|
  ActsAsTaggableOn::Tag.new(:name => tag).save
end