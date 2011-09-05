require 'happymapper'
module Dineromail
  class Notification
    include HappyMapper
    
    tag 'operacion'
    element :transaction_id, Integer, :tag => 'id'
    element :type, String, :tag => 'tipo'
    
    def initialize(options = {})
      @options = options.symbolize_keys
    end
    
    def status_report
      unless @status_report
        @status_report = StatusReport.get_report_for(transaction_id,@options)
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
    
    def self.parse(xml)
      #Convert tags to lowercase
      xml = xml.gsub(/<(.*?)[> ]/){|tag| tag.downcase}
      super(xml)
    end
    
  end
end