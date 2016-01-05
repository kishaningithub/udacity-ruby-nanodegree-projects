require_relative "person"
require_relative "ice_cream_shop"

friend = Person.new("Mike", "Wales")
print friend.first_name
print friend.last_name
print friend.name
print friend.first_name = "Michael"
print friend.name

the_freeze = IceCreamShop.new
the_freeze.add_flavor "Vanilla"
the_freeze.add_flavor "Chocolate"
the_freeze.add_flavor "Strawberry"
print the_freeze.flavors
the_freeze.remove_flavor "Vanilla"
print the_freeze.flavors
