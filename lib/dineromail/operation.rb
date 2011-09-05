require 'dineromail/item'
module Dineromail
  class Operation
    include HappyMapper
    
    tag 'operacion'
    element :transaction_id, Integer, :tag => 'id'
    element :date, DateTime, :tag => 'fecha'
    element :status, Integer, :tag => 'estado'
    element :amount, Float, :tag => 'monto'
    element :net_amount, Float, :tag => 'montoneto'
    element :pay_method, String, :tag => 'metodopago'
    element :pay_medium, String, :tag => 'mediopago'
    has_one :buyer, Buyer, :tag => 'comprador'
    has_many :items, Dineromail::Item, :tag => 'item'
    
    PENDING_STATUS = 1
    COMPLETED_STATUS = 2
    CANCELLED_STATUS = 3
    
    def pending?
      status == PENDING_STATUS
    end
    
    def completed?
      status == COMPLETED_STATUS
    end
    
    def cancelled?
      status == CANCELLED_STATUS
    end
    
  end
end