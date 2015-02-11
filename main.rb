require "sinatra"

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
  elsif
  end
end


get "/find" do
  
  if params[:field_to_edit] != nil
    redirect to "edit"
  end
end


get "/fetch_by" do 
end


before "/list_all" do
  if params[:table_name] == "locations"
    @table_name = "locations"
  elsif params[:table_name] == "products"
    @table_name = "products"
  elsif params[:table_name] == "categories"
    @table_name = "categories"
  end
end


get "/list_all" do
end


get "/edit" do 
end


