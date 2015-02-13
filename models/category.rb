require 'pry'
require 'sqlite3'

require_relative "warehouse_methods.rb"

# Class: Category
#
# Creates new category objects/records for categories table in warehouse_mgr database
# 
# Attributes:
# + @id     - Integer: 
# + @name   - String: 
#
# Public Methods:
# None.
#
# Private Methods:
# + initialize

class Category
  
  attr_reader :id
  
  include WarehouseMethods

  # Private: .initialize
  # Gathers arguments (field values) in an options Hash
  #
  # Parameters:
  # + options = {name: String} ##Should we include id? User should never input##
  #
  # Returns: 
  # Attribute values
  # 
  # State Changed:
  # ???
  
  def initialize(options)
    @name = options[:name]
  end
    
end
