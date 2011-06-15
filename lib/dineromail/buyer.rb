module Dineromail
  class Buyer
    include HappyMapper
    
    tag 'COMPRADOR'
    element :email, String, :tag => 'EMAIL'
    element :address, String, :tag => 'DIRECCION'
    element :name, String, :tag => 'NOMBRE'
    element :phone, String, :tag => 'TELEFONO'
    element :document_type, String, :tag => 'TIPODOC'
    element :document_number, String, :tag => 'NUMERODOC'
    element :comment, String, :tag => 'COMENTARIO'
    
  end
end