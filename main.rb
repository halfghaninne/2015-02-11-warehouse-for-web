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

get "/redirect" do
  if params[:method_to_call] == "find"
    redirect to "/find"
  elsif params[:method_to_call] == "fetch_by"
    redirect to "/fetch_by"
  elsif params[:method_to_call] == "list_all" ### CHECK - locations ###
      if params[:table_name] == "locations"
        redirect to "/list_all_locations"
      end
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


# before "/list_all" do
#   if params[:table_name] == "locations"
#     redirect "/list_all_locations"
#   # elsif params[:table_name] == "products"
#   #   @table_name = "products"
#   #   redirect "/list_all"
# #   elsif params[:table_name] == "categories"
# #     @table_name = "categories"
# #     @class = Category
#   end
# end


get "/list_all_locations" do
  @table_name = "locations"
  @locations_all = Location.all("locations")
  
  erb :"locations/list_all"
end

# get "/list_all_products" do
#   @table_name = "products"
#   @products_all = Location.all("products")
#
#   erb :"products/list_all"
# end
#
# get "/list_all_categories" do
#   @table_name = "categories"
#   @categories_all = Location.all("categories")
#
#   erb :"categories/list_all"
# end

get "/new_product" do
  erb :"product/new_product"
  # if we want to nest folders within /views this would read
  # erb :"products/new"
end

get "/confirm_product" do
  @serial_number = params[:serial_number].to_i
  @description = params[:description]
  @location_id = params[:location_id].to_i
  @category_id = params[:category_id].to_i
  @cost = params[:cost].to_i
  @quantity = params[:quantity].to_i
  
  erb :"product/confirm_product"
end

get "/added_product" do
  @serial_number = params[:serial_number].to_i
  @description = params[:description]
  @location_id = params[:location_id].to_i
  @category_id = params[:category_id].to_i
  @cost = params[:cost].to_i
  @quantity = params[:quantity].to_i
  
  
  added_product = Product.new("serial_number" => @serial_number, "description" => @description,
  "location_id" => @location_id, "category_id" => @category_id, "cost" => @cost,
  "quantity" => @quantity)
  
  added_product.insert("products")
  
  @id = added_product.id
  
  erb :"product/added_product"
end

#
#
# get "/edit" do
# end