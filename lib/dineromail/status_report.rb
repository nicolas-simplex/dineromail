require 'xmlsimple'
require 'httparty'
require 'dineromail/buyer'
module Dineromail
  class StatusReport
    attr_accessor :transaction_id, :date, :status, :amount, :net_amount, :pay_method, :pay_medium, :buyer
    
    PENDING_STATUS = 1
    ACCREDITED_STATUS = 2
    CANCELLED_STATUS = 3
    
    def initialize(transaction_id = nil)
      if transaction_id
        obtain_status_report_data_for transaction_id
      end
    end
    
    def obtain_status_report_data_for(transaction_id)
      self.transaction_id = transaction_id
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
      parse_response response.body
    end
   
    def parse_response(response)
      response_data = XmlSimple.xml_in(response,'KeyToSymbol' => true )
      operation = response_data[:detalle].first[:operaciones].first[:operacion].first
      self.transaction_id = operation[:id].first
      self.date = operation[:fecha].first
      self.status = operation[:estado].first.to_i
      self.amount = operation[:monto].first.to_f
      self.net_amount = operation[:montoneto].first.to_f
      self.pay_method = operation[:metodopago].first
      self.pay_medium = operation[:mediopago].first
      buyer_data = operation[:comprador].first
      self.buyer = Buyer.new
      buyer.email = buyer_data[:email].first
      buyer.address = buyer_data[:direccion].first
      buyer.comment = buyer_data[:comentario].first
      buyer.name = buyer_data[:nombre].first
      buyer.phone = buyer_data[:telefono].first
      buyer.document_type = buyer_data[:tipodoc].first
      buyer.document_number = buyer_data[:numerodoc].first
    end
    
  end
end