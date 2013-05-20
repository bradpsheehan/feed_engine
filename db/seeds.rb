# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

run1 = Run.new
run1.name = 'gSchool Runners'
run1.run_date = '#{Date.today}'
run1.run_start_time = '#{Time.now}'
run1.details = "Don't be late!"
run1.save

run2 = Run.new
run2.name = 'New York Marathon Training'
run2.run_date = '#{Date.today}'
run2.run_start_time = '#{Time.now}'
run2.details = "Make sure to bring your A Game"
run2.save

