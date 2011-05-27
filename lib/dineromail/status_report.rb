require 'xmlsimple'
require 'dineromail/buyer'
module Dineromail
  class StatusReport
    attr_accessor :transaction_id, :date, :status, :net_amount, :pay_method, :pay_medium, :buyer
    
    def initialize(transaction_id)
      self.transaction_id = transaction_id
      obtain_status_report_data
    end
    
    protected
    
    def obtain_status_report_data
      account_number = Dineromail.configuration.account_number
      password = Dineromail.configuration.password
      ipn_url = Dineromail.configuration.ipn_url
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
            <DETALLE>
          </REPORTE>"
      response = HTTParty.get ipn_url , :query => {:data => request_data}
      parse_response response
    end
    
    def parse_response response
      
    end
    
  end
end