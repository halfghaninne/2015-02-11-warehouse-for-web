require 'pry'
require 'sqlite3'

DATABASE = SQLite3::Database.new("warehouse_mgr.db")

require_relative "warehouse_mgr_setup.rb"
require_relative "location.rb"
require_relative "category.rb"
require_relative "product.rb"


# puts "WELCOME TO THE WAREHOUSE MANAGEMENT SYSTEM! \n\n What would you like to do? \n\n"
# puts "1 - Pull up product records for a location\n2 - Pull up product record"
# puts "3 - Edit product information\n4 - Transfer product\n5 - Delete a product"
# puts "6 - Delete a location or category"
# ## need to add in delete a location (if location has no stock) ##
# selection = gets.chomp.to_i
#
# valid_answers = [1, 2, 3, 4, 5, 6]

until valid_answers.include?(selection)
  puts "I'm sorry that is not a valid selection. What would you like to do? \n\n"
  puts "1 - Pull up product records for a location\n2 - Pull up product record"
  puts "3 - Edit product information\n4 - Transfer product\n5 - Delete a product"
  selection = gets.chomp.to_i
end
  
if selection == 1 # Pull up all records for a location
  puts "Please enter the location's id:"
  id = gets.chomp.to_i
  
  Product.fetch_by("location_id" => id)
  
  
elsif selection == 2 # Pull up a product record
  puts "Please enter the id of the product:" #wanted to include name, coudln't
  search_query = gets.chomp
  
  a = Product.find("products", search_query)
  
  puts "Serial Number: #{a.serial_number}\nDescription: '#{a.description}'"
  puts "Quantity: #{a.quantity}\nCost: #{a.cost}\nLocation: #{a.location_id}"
  puts "Category: #{a.category_id}"
  
  # if Integer(search_query)
  #   Product.find("products", search_query)
  # elsif String(search_query)
  #   Product.fetch_by("description" => search_query)
  # end
  
elsif selection == 3 # Edit product information
  puts "Please enter the id of the product record you would like to edit:"
  search_query = gets.chomp
  
  a = Product.find("products", search_query)
  
  puts "Which of the following would you like to edit?"
  puts "#{a.list_attributes}"
  fields_to_edit = gets.chomp
  
  puts "What would you like to set it to?"
  new_value = gets.chomp
  
  a.fields_to_edit = new_value
  
  puts a 
  
elsif selection == 4 # Transfer product
  
  
  
elsif selection == 5 # Delete a product
  puts "Please enter the id of the product you would like to delete:"
  id = gets.chomp.to_i
  
  Product.delete("products", id)
  
elsif selection == 6 # Delete a location or category
  puts "Would you like to delete (1) a location or (2) a category?"
  a = gets.chomp.to_i
  
  
end
  