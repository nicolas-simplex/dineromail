require 'xmlsimple'
module Dineromail
  class Notification
    
    attr_reader :transaction_id, :tipo
    
    def initialize(transaction_id, tipo = null)
      @transaction_id = transaction_id
      @tipo = tipo
    end
    
    def status_report
      unless @status_report
        @status_report = StatusReport.new(transaction_id)
      end
      @status_report
    end
    
    def self.from_xml(notification_xml)
      notifications = []
      notificaction_data = XmlSimple.xml_in(notification_xml,'KeyToSymbol' => true)
      operations = notificaction_data[:operaciones].first[:operacion]
      operations.each do |operation|
        tipo = operation[:tipo].first
        transaction_id = operation[:id].first
        notifications << self.new(transaction_id, tipo)
      end
      notifications
    end
    
  end
end