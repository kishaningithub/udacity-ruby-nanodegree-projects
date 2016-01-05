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

def get_products_section_data(products) # No Side Effects
    products_report_data =[]
    products.each do |product|
        product_title =  product['title']
        retail_price = product['full-price'].to_f
        total_purchases = product['purchases'].length 
        total_sales = product['purchases'].map{|purchase| purchase['price']}.reduce(:+)  # Total amount of sales
        avg_price = total_sales / total_purchases  # Average price the toy sold for
        avg_discount = ( (retail_price - avg_price) / retail_price) * 100  # Average discount based off the average sales price
        
        products_report_data <<
        {
            product_title: product_title, 
            retail_price: retail_price,
            total_purchases: total_purchases,
            total_sales: total_sales,
            avg_price: avg_price,
            avg_discount: avg_discount.round(2)
        }
    end
    products_report_data
end

def get_printable_products_section(report_data_lst) # No Side Effects
    lines = []
    star_sep = "*" * 35
    report_data_lst.each do |report_data|
        lines << report_data[:product_title] # Human readable name of the toy
        lines << star_sep
        lines << "Retail Price: $#{report_data[:retail_price]}" # Human readable retail price of the toy
        lines << "Total Purchases: #{report_data[:total_purchases]}" # Human readable total number of purchases
        lines << "Total Sales Volume: $#{report_data[:total_sales]}" # Human readable total amount of sales
        lines << "Average Price: $#{report_data[:avg_price]}" # Human readable average price the toy sold for
        lines << "Average Discount: #{report_data[:avg_discount]}%" # Human readable average discount based off the average sales price
        lines << ""
    end
    if lines.length > 0
        lines.pop
    end
    lines
end

def make_products_section(products_hash)  # No Side Effects
    report_data_lst = get_products_section_data products_hash['items']
    get_printable_products_section report_data_lst
end

def get_brands_section_data(products)  # No Side Effects
    brand_report_data = []
    brands = products.map{|product| product['brand']}.uniq
    brands.each do |brand|
        products_in_brand = products.select {|product| product['brand'] == brand}
        brand_name = brand # name of the brand
        no_of_products = products_in_brand.map {|product| product['stock']}.reduce(:+) # Number of the brand's toys we stock
        
        total_price = products_in_brand.map {|product| product['full-price'].to_f}.reduce(:+) 
        avg_price = total_price / products_in_brand.length # Average price of the brand's toys
        total_sales = products_in_brand.map {|product| product['purchases']}.flatten.map{|purchase| purchase['price'].to_f}.reduce(:+) # Total sales volume of all the brand's toys combined

        brand_report_data << 
        {
            brand_name: brand_name,
            no_of_products: no_of_products,
            avg_price: avg_price.round(2),
            total_sales: total_sales.round(2)
        }
      end   
    brand_report_data
end

def get_printable_brands_section(report_data_lst)  # No Side Effects
    lines = []
    star_sep = "*" * 35
    report_data_lst.each do |report_data|
        lines << report_data[:brand_name] # Human readable name of the brand
        lines << star_sep
        lines << "Number of Products: #{report_data[:no_of_products]}" # Human readable number of the brand's toys we stock
        lines << "Average Product Price: $#{report_data[:avg_price]}" # Human readable average price of the brand's toys
        lines << "Total Sales: $#{report_data[:total_sales]}" # Human readable total sales volume of all the brand's toys combined
        lines << ""
    end
    if lines.length > 0
        lines.pop
    end
    lines
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