class IceCreamShop
    attr_accessor :flavors
    
    def initialize
        @flavors = []
    end
    
    def add_flavor(flavour)
        @flavors << flavour
    end
    
    def remove_flavor(flavour)
        @flavors.delete flavour
    end
    
    
end