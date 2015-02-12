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
  elsif params[:method_to_call] == "new_product" 
    redirect to "/new_product"
  elsif params[:list_all_of] == "all_locations" 
      redirect to "/list_all_locations"
  elsif params[:list_all_of] == "all_products" 
      redirect to "/list_all_products"
  elsif params[:list_all_of] == "all_categories" 
      redirect to "/list_all_categories"
  end
end

get "/find" do
  erb :"product/find_specific_product"
end

get "/return_product" do
  @id = params[:search_id].to_i
  @description = params[:search_description]
  
  #if params[:search_description].length == 0
    @product_with_id = Product.find("products", @id)
    
    @serial_number = @product_with_id.serial_number
    @description = @product_with_id.description
    @quantity = @product_with_id.quantity
    @cost = @product_with_id.cost
    @location_id = @product_with_id.location_id
    @category_id = @product_with_id.category_id
  #######################################################
  # FEATURE DOES NOT WORK YET IN WAREHOUSE RUBY PROGRAM #
  #######################################################
  # else
  #   @product_with_description = Product.fetch_by("description" => @description)
  #
  #   @id = @product_with_description.id
  #   @serial_number = @product_with_description.serial_number
  #   @quantity = @product_with_description.quantity
  #   @cost = @product_with_description.cost
  #   @location_id = @product_with_description.location_id
  #   @category_id = @product_with_description.category_id
  #end
  
  erb :"product/return_product"
end

get "/fetch_by" do
end


get "/list_all_locations" do
  @table_name = "locations"
  @locations_all = Location.all("locations")
  
  erb :"location/list_all"
end

get "/list_all_products" do 
  @table_name = "products"
  @products_all = Product.all("products")
  
  erb :"product/list_all"
end
  
get "/list_all_categories" do 
  @table_name = "categories"
  @categories_all = Category.all("categories")
  
  erb :"category/list_all"
end

get "/new_product" do
  erb :"product/new_product"
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

# get "/edit" do
# end