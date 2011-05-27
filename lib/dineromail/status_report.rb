require 'xmlsimple'
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
      parse_response response.body
    end
   
    def parse_response(response)
      response_data = XmlSimple.xml_in(response)
      operation = response_data['DETALLE'].first['OPERACIONES'].first['OPERACION'].first
      self.transaction_id = operation['ID'].first
      self.date = operation['FECHA'].first
      self.status = operation['ESTADO'].first.to_i
      self.amount = operation['MONTO'].first.to_f
      self.net_amount = operation['MONTONETO'].first.to_f
      self.pay_method = operation['METODOPAGO'].first
      self.pay_medium = operation['MEDIOPAGO'].first
      buyer_data = operation['COMPRADOR'].first
      self.buyer = Buyer.new
      buyer.email = buyer_data['EMAIL'].first
      buyer.address = buyer_data['DIRECCION'].first
      buyer.comment = buyer_data['COMENTARIO'].first
      buyer.name = buyer_data['NOMBRE'].first
      buyer.phone = buyer_data['TELEFONO'].first
      buyer.document_type = buyer_data['TIPODOC'].first
      buyer.document_number = buyer_data['NUMERODOC'].first
    end
    
  end
end