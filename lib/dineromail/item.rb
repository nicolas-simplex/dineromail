module Dineromail
  class Item
    attr_accessor :description, :currency, :unit_price, :count
    
    DOLLAR = 2
    PESO = 1
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    
  end
end