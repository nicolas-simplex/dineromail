require 'happymapper'
module Dineromail
  class Notification
    include HappyMapper
    
    tag 'OPERACION'
    element :transaction_id, Integer, :tag => 'ID'
    element :type, String, :tag => 'TIPO'
    
    def status_report
      unless @status_report
        @status_report = StatusReport.get_report_for(transaction_id)
      end
      @status_report
    end
    
    def valid_report?
      status_report.valid_report?
    end
    
    def method_missing(symbol, *args)
      unless status_report.operations.empty?
        status_report.operations.first.send(symbol, *args)
      end
    end
    
  end
end