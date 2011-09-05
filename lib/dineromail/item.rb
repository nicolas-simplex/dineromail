module Dineromail
  class Item
    include HappyMapper
    
    tag 'item'
    element :description, String, :tag => 'descripcion'
    element :currency, Integer, :tag => 'moneda'
    element :unit_price, Float, :tag => 'preciounitario'
    element :count, Integer, :tag => 'cantidad'
    
    DOLLAR = 2
    PESO = 1    
    
  end
end