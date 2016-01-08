class TodoList
    
     def initialize(list_title)
        @title = list_title
        @items = Array.new # Starts empty! No Items yet!
     end
     
    def add_item(new_item)
        item = Item.new(new_item)
        @items.push(item)
    end
    
    def delete_item_at(index)
        @items.delete_at(index - 1) # Just to make it more "human friendly (delete first item)"
    end    
    
    def update_completion_status_at(index)
        item = @items[index - 1] # Just to make it more "human friendly (Update the completion status of first item)"
        item.update_completion_status
    end
    
    def rename(new_title)
        @title = new_title
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
        print_lst << " "
        print_lst.join("\n")
    end
    
end

class Item

    def initialize(item_description)
        @description = item_description
        @completed_status = false
    end
    
    def update_completion_status
        @completed_status = ! @completed_status
    end
    
    def completed?
        @completed_status
    end
    
    def to_s
        "#{@description} Completed: #{completed?}"
    end
    
end
