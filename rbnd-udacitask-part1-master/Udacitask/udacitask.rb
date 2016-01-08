require './todolist.rb'

# Creates a new todo list
toto_lst = TodoList.new("Julia's Stuff")

# Add four new items
toto_lst.add_item("Do laundry")
toto_lst.add_item("Feed the cat")
toto_lst.add_item("Buy cereal")
toto_lst.add_item("Go dancing!")

# Print the list
puts toto_lst

# Delete the first item
puts "Deleting the first item"
toto_lst.delete_item_at(1)

# Print the list
puts toto_lst

# Delete the second item
puts "Deleting the second item"
toto_lst.delete_item_at(2)

# Print the list
puts toto_lst

# Update the completion status of the first item to complete
puts "Updating the completion status of the first item to complete"
toto_lst.update_completion_status_at(1)

# Print the list
puts toto_lst

# Update the title of the list
puts "Updating the title of the list"
toto_lst.rename("Kishan's Stuff")

# Print the list
puts toto_lst
