require 'dineromail/item'
module Dineromail
  class Operation
    include HappyMapper
    
    tag 'OPERACION'
    element :transaction_id, Integer, :tag => 'ID'
    element :date, DateTime, :tag => 'FECHA'
    element :status, Integer, :tag => 'ESTADO'
    element :amount, Float, :tag => 'MONTO'
    element :net_amount, Float, :tag => 'MONTONETO'
    element :pay_method, String, :tag => 'METODOPAGO'
    element :pay_medium, String, :tag => 'MEDIOPAGO'
    has_one :buyer, Buyer, :tag => 'COMPRADOR'
    has_many :items, Dineromail::Item, :tag => 'ITEM'
    
    PENDING_STATUS = 1
    COMPLETED_STATUS = 2
    CANCELLED_STATUS = 3
    
    def pending?
      status == PENDING_STATUS
    end
    
    def completed?
      status == ACCREDITED_STATUS
    end
    
    def cancelled?
      status == CANCELLED_STATUS
    end
    
  end
end