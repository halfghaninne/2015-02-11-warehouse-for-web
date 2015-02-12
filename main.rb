require "sinatra"

require 'pry'
require 'sqlite3'

DATABASE = SQLite3::Database.new("warehouse_mgr.db")

require_relative "warehouse_mgr_setup.rb"
require_relative "warehouse_methods.rb"
require_relative "location.rb"
require_relative "category.rb"
require_relative "product.rb"


get "/" do 
  erb :homepage
end


### SHOULD THIS BE A METHOD INSTEAD OF A PATH??? ###
get "/redirect" do
  if params[:method_to_call] == "find"
    redirect to "/find"
  elsif params[:method_to_call] == "fetch_by"
    redirect to "/fetch_by"
  elsif params[:method_to_call] == "list_all"
    redirect to "/list_all"
  elsif params[:method_to_call] == "new_product"
    redirect to "/new_product"
  end
end


# get "/find" do
#
#   if params[:field_to_edit] != nil
#     redirect to "edit"
#   end
# end
#
#
# get "/fetch_by" do
# end


before "/list_all" do
  if params[:table_name] == "locations"
    @table_name = "locations"
    redirect "/list_all"
  # elsif params[:table_name] == "products"
  #   @table_name = "products"
  #   redirect "/list_all"
#   elsif params[:table_name] == "categories"
#     @table_name = "categories"
#     @class = Category
  end
end


get "/list_all" do
  @locations_all = Location.all("locations")
  
  erb :locations_list_all
end

get "/new_product" do
  erb :new_product
end

get "/confirm_product" do
  @serial_number = params[:serial_number].to_i
  @description = params[:description]
  @location_id = params[:location_id].to_i
  @category_id = params[:category_id].to_i
  @cost = params[:cost].to_i
  @quantity = params[:quantity].to_i
  
  erb :confirm_product
end

get "/added_product" do
  @serial_number = params[:serial_number].to_i
  @description = params[:description]
  @location_id = params[:location_id].to_i
  @category_id = params[:category_id].to_i
  @cost = params[:cost].to_i
  @quantity = params[:quantity].to_i
  
  binding.pry 
  
  added_product = Product.new("serial_number" => @serial_number, "description" => @description,
  "location_id" => @location_id, "category_id" => @category_id, "cost" => @cost,
  "quantity" => @quantity)
  
  @id = added_product.id
  
  erb :added_product
end

#
#
# get "/edit" do
# end