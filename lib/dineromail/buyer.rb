module Dineromail
  class Buyer
    include HappyMapper
    
    tag 'comprador'
    element :email, String, :tag => 'email'
    element :address, String, :tag => 'direccion'
    element :name, String, :tag => 'nombre'
    element :phone, String, :tag => 'telefono'
    element :document_type, String, :tag => 'tipodoc'
    element :document_number, String, :tag => 'numerodoc'
    element :comment, String, :tag => 'comentario'
    
  end
end