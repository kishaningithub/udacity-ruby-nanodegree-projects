class TodoList
    
     def initialize(list_title)
        @title = list_title
        @items = Array.new # Starts empty! No Items yet!
     end
     
    def add_item(new_item)
        item = Item.new(new_item)
        @items.push(item)
    end
    
    def to_s
        header_divider = "-" * 20
        print_lst = []
        print_lst << header_divider
        print_lst << @title
        print_lst << header_divider
        @items.each.with_index(1)  do |item, index|
           print_lst << "#{index} - #{item}"
        end
        print_lst.join("\n")
    end
    
end

class Item
    attr_reader :description, :completed_status
    
    def initialize(item_description)
        @description = item_description
        @completed_status = false
    end
    
    def to_s
        "#{@description} Completed: #{@completed_status}"
    end
    
end
