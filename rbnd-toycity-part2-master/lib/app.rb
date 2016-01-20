require 'json'

def get_heading(heading_type) # No Side Effects
    case heading_type
    when :sales_report
"
  #####                                 ######                                    
 #     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####
 #        #  #  #      #      #         #     # #      #    # #    # #    #   #  
  #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #  
       # ###### #      #           #    #   #   #      #####  #    # #####    #  
 #     # #    # #      #      #    #    #    #  #      #      #    # #   #    #  
  #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #  
********************************************************************************
"
   
    when :brands
"
 _                         _     
| |                       | |    
| |__  _ __ __ _ _ __   __| |___ 
| '_ \\| '__/ _` | '_ \\ / _` / __|
| |_) | | | (_| | | | | (_| \\__ \\
|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
   
    when :products
"
                     _            _       
                    | |          | |      
 _ __  _ __ ___   __| |_   _  ___| |_ ___ 
| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|
| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\
| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/
| |                                       
|_|                                       "
    else ""
    end
end

# Operations on single product - Start
def product_title(product)
   product['title'] 
end

def retail_price(product)
    product['full-price'].to_f
end

def total_purchases(product)
    product['purchases'].length 
end

def total_sales(product)
    product['purchases'].map{|purchase| purchase['price']}.reduce(:+)  # Total amount of sales
end

def avg_price(product)
    total_sales(product) / total_purchases(product)  # Average price the toy sold for
end

def avg_discount(product)
    ( (retail_price(product) - avg_price(product)) / retail_price(product)) * 100  # Average discount based off the average sales price
end
#Operations on single product - End

def get_products_section_data(products) # No Side Effects
    products.map do |product|
        {
            product_title: product_title(product), 
            retail_price: retail_price(product),
            total_purchases: total_purchases(product),
            total_sales: total_sales(product),
            avg_price: avg_price(product),
            avg_discount: avg_discount(product).round(2)
        }
    end
end

def star_sep
    "*" * 35
end

def get_printable_products_section(report_data_lst) # No Side Effects
    report_data_lst.map do |report_data|
        [report_data[:product_title], # Human readable name of the toy
         star_sep,
         "Retail Price: $#{report_data[:retail_price]}", # Human readable retail price of the toy
         "Total Purchases: #{report_data[:total_purchases]}", # Human readable total number of purchases
         "Total Sales Volume: $#{report_data[:total_sales]}", # Human readable total amount of sales
         "Average Price: $#{report_data[:avg_price]}", # Human readable average price the toy sold for
         "Average Discount: #{report_data[:avg_discount]}%", # Human readable average discount based off the average sales price
         ""]
    end
end

def make_products_section(products_hash)  # No Side Effects
    report_data_lst = get_products_section_data products_hash['items']
    get_printable_products_section report_data_lst
end

# Operations on product array - Start
def products_brands(products)
    products.map{|product| product['brand']}.uniq
end

def products_in_brand(products, brand)
    products.select {|product| product['brand'] == brand}
end

def products_no_of_products(products)
    products.map {|product| product['stock']}.reduce(:+) # Number of the brand's toys we stock
end

def products_total_price(products)
   products.map {|product| product['full-price'].to_f}.reduce(:+)  
end

def products_avg_price(products)
    products_total_price(products) / products.length
end

def products_total_sales(products)
    products.map {|product| product['purchases']}.flatten.map{|purchase| purchase['price'].to_f}.reduce(:+) # Total sales volume of all the brand's toys combined
end
# Operations on product array - End

def get_brands_section_data(products)  # No Side Effects
    products_brands(products).map do |brand_name|
        products_in_brand = products_in_brand(products, brand_name)
        {
            brand_name: brand_name,
            no_of_products: products_no_of_products(products_in_brand),
            avg_price: products_avg_price(products_in_brand).round(2),
            total_sales: products_total_sales(products_in_brand).round(2)
        }
    end   
end

def get_printable_brands_section(report_data_lst)  # No Side Effects
    report_data_lst.map do |report_data|
        [report_data[:brand_name], # Human readable name of the brand
         star_sep,
         "Number of Products: #{report_data[:no_of_products]}", # Human readable number of the brand's toys we stock
         "Average Product Price: $#{report_data[:avg_price]}", # Human readable average price of the brand's toys
         "Total Sales: $#{report_data[:total_sales]}", # Human readable total sales volume of all the brand's toys combined
         ""]
    end
end

def make_brands_section(products_hash) # No Side Effects
  report_data_lst = get_brands_section_data products_hash['items']
  get_printable_brands_section report_data_lst
end

def setup_files # Has Side Effects!
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    products_hash = JSON.parse(file)
    report_file = File.new("report.txt", "w") # Im only going to write so changed from read-write (w+) to only write (w)
    return products_hash, report_file
end

def create_report(products_hash, report_file) # Has Side Effects!
    report_file.puts get_heading :sales_report  # Print "Sales Report" in ascii art
    
    report_file.puts Time.now.strftime("Generated On: %d-%b-%Y") # Print today's date
    
    report_file.puts get_heading :products # Print "Products" in ascii art
    report_file.puts make_products_section products_hash
    
	report_file.puts get_heading :brands # Print "Brands" in ascii art
	report_file.puts make_brands_section products_hash
end

def start # Has Side Effects! Obviously
  products_hash, report_file = setup_files # load, read, parse, and create the files
  create_report products_hash, report_file # create the report!
  report_file.close
end

start