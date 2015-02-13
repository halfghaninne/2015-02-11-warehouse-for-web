require 'pry'
require 'sqlite3'

require_relative "warehouse_methods.rb"

# Class: Product
#
# Creates new product objects/records for products table in warehouse_mgr database
# 
# Attributes:
# + @id              - Integer: Primary key ##user shouldn't overwrite##
# + @serial_number   - Integer 
# + @description     - String:
# + @quantity        - Integer:
# + @cost            - Integer: ##CONSIDER CHANGING TO FLOAT/OTHER VALUE##
# + @location_id     - Integer: Foreign key ##RESTRICT VALUES##
# + @category_id     - Integer: Foreign key ##RESTRICT VALUES##
#
# Public Methods:
# None.
#
# Private Methods:
# + initialize

class Product
  
  attr_reader :id
  
  attr_accessor :location_id, :cost, :quantity, :serial_number, :description, 
                :category_id
                
  include WarehouseMethods
  
  # Private: .initialize
  # Gathers arguments (field values) in an options Hash
  #
  # Parameters:
  # + options = {"serial_number" => Integer, "name" => String, "descriptio" => String, "quantity" => Integer, "cost" => Integer, "location_id" => Integer, "category_id" => Integer}
  #
  # Returns: 
  # Attribute values.
  # 
  # State Changed:
  # ???
  
  def initialize(options)
    @serial_number = options["serial_number"]
    @description = options["description"]
    @quantity = options["quantity"]
    @cost = options["cost"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
  end
  
  # Public: .fetch_by
  # Returns product records that have a given field value, expressed in a (key, value) pair within an options Hash.
  # For example Product.fetch_by("location_id" => 2) would return all records in the products table with a location_id of 2. They would be returned as objects.
  #
  # Parameters:
  # + options ={"field name" => desired value}
  #
  # Returns: 
  # Objects: Records from the products table, expressed as Ruby Objects.
  #
  # State Changes:
  # None
  
  def self.fetch_by(options) #ex: Product.fetch_by("location_id" => 2)
    v = []
    k = []
    options.each_key {|key| k << "#{key}"}
    options.each_value {|value| v << "#{value}"}

    field = k[0].to_s
    search_value = v[0].to_i #fix this later!

    search_query = "SELECT * FROM products WHERE #{field} = #{search_value}"
    
    results = DATABASE.execute("#{search_query}")

    results_as_objects = []

    results.each do |r|
      results_as_objects << self.new(r)
    end
#
#     # n = results_as_objects.length
#
#     x = 0
#
#     until x == results_as_objects.length
#       puts "Description: '#{results_as_objects[x].description}' Quantity: #{results_as_objects[x].quantity}"
#       x+=1
#     end

  end
  
  # def edit(options)
  #   fetch_by(options)
  #
  #
  # end

end