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
end

def get_printable_products_section(report_data_lst) # No Side Effects
end

def make_products_section(products_hash)  # No Side Effects
end

def get_brands_section_data(products)  # No Side Effects
end

def get_printable_brands_section(report_data_lst)  # No Side Effects
end

def make_brands_section(products_hash) # No Side Effects
end

def setup_files # Has Side Effects!
end

def create_report(products_hash, report_file) # Has Side Effects!
end

def start # Has Side Effects! Obviously
end

start