require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
puts Time.now.strftime("Todays Date: %d-%b-%Y")

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "



# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calcalate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount based off the average sales price

star_sep = "*" * 20

products = products_hash ['items']

products.each do |product|
    puts product['title']
    puts star_sep
    retail_price = product['full-price'].to_f
    puts "Retail Price: $#{retail_price}"
    total_purchases = product['purchases'].length
    puts "Total Purchases: #{total_purchases}"
    total_sales = product['purchases'].map{|purchase| purchase['price']}.reduce(:+)
    puts "Total Sales: $#{total_sales}"
    average_price = total_sales / total_purchases
    puts "Average Price: $#{average_price}"
    sum_of_discount_pct =  product['purchases'].map{|purchase| (((retail_price - purchase['price'].to_f) * 100) / retail_price) }.reduce(:+)
    avg_discount = sum_of_discount_pct / total_purchases
    puts "Average Discount: #{avg_discount.round(2)}%"
    puts
  end



	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

brands = products_hash['items'].map{|product| product['brand']}.uniq
brands.each do |brand|
    products_in_brand = products.select {|product| product['brand'] == brand}
    puts brand
    puts star_sep
    no_of_products = products_in_brand.length
    puts "Number of products: #{no_of_products}"
    total_price = products_in_brand.map {|product| product['full-price'].to_f}.reduce(:+) 
    avg_price = total_price / no_of_products
    puts "Average Product Price: $#{avg_price.round 2}"
    total_sales = products_in_brand.map {|product| product['purchases']}.flatten.map{|purchase| purchase['price'].to_f}.reduce(:+)
    puts "Total Sales: $#{total_sales.round 2}"
    puts
  end