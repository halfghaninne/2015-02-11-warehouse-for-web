require 'pry'
require 'sqlite3'

require_relative "warehouse_methods.rb"

# Class: Location
#
# Creates new location objects/records for locations table in warehouse_mgr database
# 
# Attributes:
# + @id     - Integer: 
# + @city   - String: 
#
# Public Methods:
# None.
#
# Private Methods:
# + initialize

class Location
  
  attr_reader :id
  
  include WarehouseMethods
  
  # Private (triggered by .new): .initialize
  # Gathers arguments (field values) in an options Hash.
  #
  # Parameters:
  # + options = {city: String}
  #
  # Returns: 
  # ???
  # 
  # State Changed:
  # ???
  
  def initialize(options)
    @city = options[:city]
  end

end



