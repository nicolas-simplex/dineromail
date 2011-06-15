require 'happymapper'
require 'httparty'
require 'dineromail/buyer'
require 'dineromail/operation'
module Dineromail
  class StatusReport
    attr_accessor :transaction_id
    
    include HappyMapper
    
    tag 'REPORTE'
    element :report_status, Integer, :tag => 'ESTADOREPORTE'
    has_many :operations, Operation
    
    VALID_REPORT_STATUS = 1
    MALFORMED_REPORT_STATUS = 2
    INVALID_ACCOUNT_NUMBER_REPORT_STATUS = 3
    INVALID_PASSWORD_REPORT_STATUS = 4
    INVALID_REQUEST_TYPE_STATUS = 5
    INVALID_TRANSACTION_ID_REQUEST_STATUS = 6
    INVALID_PASSWORD_OR_ACCOUNT_NUMBER_REQUEST_STATUS = 7
    TRANSACTION_NOT_FOUND_REQUEST_STATUS = 8
    
    def valid_report?
      report_status == VALID_REPORT_STATUS
    end
    
    
    def self.get_report_for(transaction_id)
      account_number = Dineromail.configuration.account_number
      password = Dineromail.configuration.password
      ipn_url = Dineromail.configuration.ipn_webservice_url
      request_data = "<REPORTE>
            <NROCTA>#{account_number}</NROCTA>
            <DETALLE>
            <CONSULTA>
              <CLAVE>#{password}</CLAVE>
              <TIPO>1</TIPO>
              <OPERACIONES>
                <ID>#{transaction_id}</ID>
              </OPERACIONES>
            </CONSULTA>
            </DETALLE>
          </REPORTE>"
      response = HTTParty.get ipn_url , :query => {:data => request_data}
      self.parse response.body
    end
    
  end
end