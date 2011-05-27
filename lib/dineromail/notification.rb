require 'xmlsimple'
module Dineromail
  class Notification
    
    attr_accessor :transaction_id, :tipo
    
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    
    def self.from_xml(notification_xml)
      notifications = []
      notificaction_data = XmlSimple.xml_in(notification_xml)
      operations = notificaction_data['OPERACIONES'].first['OPERACION']
      operations.each do |operation|
        tipo = operation['TIPO'].first
        transaction_id = operation['ID'].first
        notifications << self.new(:transaction_id => transaction_id, :tipo=> tipo)
      end
      notifications
    end
    
  end
end