require 'pry'
require 'minitest/autorun'

require "sqlite3"

DATABASE = SQLite3::Database.new("warehouse_test.db")

require_relative 'warehouse_mgr_setup.rb'
require_relative 'product.rb'
require_relative 'location.rb'
require_relative 'category.rb'

class WarehouseTest < Minitest::Test
  
  def setup
    DATABASE.execute("DELETE FROM products")
    DATABASE.execute("DELETE FROM locations")
    DATABASE.execute("DELETE FROM categories")
  end
  # Maybe we should move this up out of the class?
  
### LOCATION TESTS ###

  def test_location_creation
    location = Location.new({"city" => "Omaha"})
    location.insert("locations")   
    results = DATABASE.execute("SELECT city FROM locations WHERE id = #{location.id}")
    
    added_location = results[0]
    
    assert_equal(1, results.length)
    assert_equal("Omaha", added_location["city"])
  end
  
  def test_list_all_locations
    DATABASE.execute("DELETE FROM locations")
    
    l1 = Location.new({"city" => "Omaha"})
    l2 = Location.new({"city" => "Lincoln"})
    l3 = Location.new({"city" => "Kearney"})
    l1.insert("locations")
    l2.insert("locations")
    l3.insert("locations")
    assert_equal(3, Location.all.length)
  end
    
### CATEGORY TESTS ###

  def test_list_all_categories
    DATABASE.execute("DELETE FROM categories")
    
    l1 = Category.new({"name" => "Movie"})
    l2 = Category.new({"name" => "Book"})
    l1.insert("categories")
    l2.insert("categories")
    assert_equal(2, Category.all.length)
  end
  
  def test_category_creation
    category = Category.new({"name" => "Movie"})
    category.insert("categories")   
    results = DATABASE.execute("SELECT name FROM categories WHERE id = #{category.id}")
    
    added_category = results[0]
    
    assert_equal(1, results.length)
    assert_equal("Movie", added_category["name"])
  end
  
### PRODUCT TESTS ###
  
  def test_product_creation
    product = Product.new({"serial_number" => 4000, "description" => "Name of Product",
    "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})
    product.insert("products")
    
    results = DATABASE.execute("SELECT name FROM product WHERE id = #{id}")
    
    added_product = results[0]
    
    assert_equal(1, results.length)
    assert_equal("Name of Product", added_category["name"])
  end
  
  def test_list_all_products
    DATABASE.execute("DELETE FROM products")
    
    p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
    "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})
    
    p2 = Product.new({serial_number} => 5000, "description" => "Second Product",
    "quantity" => 30, "cost" => 15, "location_id" => 1, "category_id" => 3})
    p1.insert("products")
    p2.insert("products")
    assert_equal(2, Product.all.length)
  end
  
  def test_find_method
    location = Location.new({"city" => "Omaha"})
    category = Category.new({"name" => "Book"})
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
   
    location.insert("locations")
    category.insert("categories")
    product.insert("products")
    
    results1 = Product.find("products", 1)
    results2 = Location.find("locations", 1)
    results3 = Category.find("categories", 1) 
    
    assert_equal(10, results1.cost)
    assert_equal("Omaha", results2.city)
    assert_equal("Book", results3.name)                        
  end
  
  def test_delete_method
    product1 = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
                            
    product2 = Product.new({"serial_number" => 2, "description" => "Goodbye", 
                            "quantity" => 8, "cost" => 12, "location_id" => 1,
                            "category_id" => 2})
                            
    product1.insert("products")
    product2.insert("products")
    
    Product.delete("products", 1)
    
    assert_equal(1, Product.all("products").length)
  end
  
  def test_save_method
    product = Product.new({"serial_number" => 1, "description" => "Hello", 
                            "quantity" => 5, "cost" => 10, "location_id" => 1,
                            "category_id" => 3})
                            
    product.insert("products")
    
    product.quantity = 10
    
    product.save("products")
    
    assert_equal(10, product.quantity)
  end
  
  # def test_product_without_enough_info
  #   DATABASE.execute("DELETE FROM products")
  #
  #   p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
  #   "cost" => 15, "location_id" => 2, "category_id" => 2})
  #
  #   p1.insert
  #   refute_equal(1, Product.all.length)
  # end
  
  def test_product_fetching
    DATABASE.execute("DELETE FROM products")
    
    p1 = Product.new({"serial_number" => 4000, "description" => "First Product",
    "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 2})

    p2 = Product.new({serial_number} => 45000, "description" => "Second Product",
    "quantity" => 30, "cost" => 15, "location_id" => 1, "category_id" => 3})
    
    p1.insert("products")
    p2.insert("products")


    assert_equal(1, Product.fetch_by("location_id" => 2).length)
  end
  
  
  # def test_product_editing
  #   DATABASE.execute("DELETE FROM products")
  #
  #   p1 = Product.new({"serial_number" => 6000, "description" => "Test Product",
  #   "quantity" => 30, "cost" => 15, "location_id" => 2, "category_id" => 3})
  #
  #   p1.insert("products")
  #
  #   # How would we go about this? .find / .fetch_by, then .save? How would that work? do the (temporary) objects created in a find or fetch have scope outside that method?
  # end
  
  
  

end