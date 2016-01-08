require 'yaml'

class TodoList
    
    PERSISTENCE_DIR = "persisted_list"
    
    attr_reader :title, :items
    
    def initialize(list_title)
        if persisted? list_title then
            todo_lst = get_persisted_todo_lst(list_title)
            @title = todo_lst.title
            @items = todo_lst.items
        else
            @title = list_title
            @items = [] # Starts empty! No Items yet!
        end
     end
     
    def add_item(new_item, options = {sub_items: []})
        item = Item.new(new_item)
        if ! options[:sub_items].empty? then
            item.add_subitems(options[:sub_items])
        end
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
    
    def persisted?(list_title) # Function ending with ?
        File.exist? persisted_file_path list_title
    end
    
    def persisted_file_path(list_title)
        "#{PERSISTENCE_DIR}/#{list_title}.txt"
    end
    
    def persist
        Dir.mkdir PERSISTENCE_DIR unless File.exist? PERSISTENCE_DIR
        File.open(persisted_file_path(@title), "w") {|f| f.write(YAML.dump(self))}
    end
    
    def get_persisted_todo_lst(list_title)
        YAML.load(File.read(persisted_file_path(list_title)))
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
        @sub_items = []
    end
    
    def update_completion_status
        @completed_status = ! @completed_status
    end
    
    def add_subitem(item_description)
        @sub_items << Item.new(item_description)
    end
    
    def add_subitems(item_description_arr)
        item_description_arr.each { |item_description| add_subitem(item_description) }
    end
    
    def to_s
        print_lst = []
        print_lst << "#{@description} Completed: #{@completed_status}"
        print_lst << "Subtasks" unless @sub_items.empty?
        @sub_items.each.with_index(1) {|item, index| print_lst << "#{index} #{item}"}
        print_lst.join("\n")
    end
    
end
