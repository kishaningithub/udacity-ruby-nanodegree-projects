require './todolist.rb'

# Creates a new todo list
todo_lst = TodoList.new("Julia's Stuff")

# Add four new items
todo_lst.add_item("Do laundry")
todo_lst.add_item("Feed the cat")
todo_lst.add_item("Buy cereal")
todo_lst.add_item("Go dancing!")

# Print the list
puts todo_lst

# Delete the first item
puts "Deleting the first item"
todo_lst.delete_item_at(1)

# Print the list
puts todo_lst

# Delete the second item
puts "Deleting the second item"
todo_lst.delete_item_at(2)

# Print the list
puts todo_lst

# Update the completion status of the first item to complete
puts "Updating the completion status of the first item to complete"
todo_lst.update_completion_status_at(1)

# Print the list
puts todo_lst

# Update the title of the list
puts "Updating the title of the list"
todo_lst.rename("Kishan's Stuff")

# Print the list
puts todo_lst

#Save the list to a file, and load the list file if one already exists.
todo_lst.persist
puts "Persisted list"
puts TodoList.new("Kishan's Stuff")

#Implement sub tasks
puts "List with sub items"
another_todo_lst = TodoList.new("Goals")
another_todo_lst.add_item("Learn Rails", sub_items: ["Learn shell scripting", "Learn ruby", "Learn Functional programming concepts", "Dont see ruby as java"], )
puts another_todo_lst

#Implement due dates
puts "List with sub items & due dates"
another_todo_lst = TodoList.new("Goals")
another_todo_lst.add_item("Learn Rails", sub_items: ["Learn shell scripting", "Learn ruby", "Learn Functional programming concepts", "Dont see ruby as java"], due_date: Date.new(2016,12,1))
puts another_todo_lst

