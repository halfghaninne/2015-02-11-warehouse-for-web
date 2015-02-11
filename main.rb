require "sinatra"

require 'pry'
require 'sqlite3'

DATABASE = SQLite3::Database.new("warehouse_mgr.db")

require_relative "warehouse_mgr_setup.rb"
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
  erb :locations_list_all
end

get "/new_product" do
  erb :new_product
end
#
#
# get "/edit" do
# end