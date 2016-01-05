class Person 
    attr_accessor :first_name, :last_name
    attr_reader :name
    
    def initialize(first_name, last_name) 
        @first_name = first_name
        @last_name = last_name
        @name = first_name + " " + last_name
    end
end
    