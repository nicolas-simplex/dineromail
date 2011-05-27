module Dineromail
  class Buyer
    attr_accessor :email, :address, :name, :phone, :document_type, :document_number, :comment
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    
  end
end