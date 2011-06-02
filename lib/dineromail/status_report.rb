require 'xmlsimple'
require 'httparty'
require 'dineromail/buyer'
module Dineromail
  class StatusReport
    attr_accessor :transaction_id, :date,:report_status, :status, :amount, :net_amount, :pay_method, :pay_medium, :buyer, :items
    
    PENDING_STATUS = 1
    COMPLETED_STATUS = 2
    CANCELLED_STATUS = 3
    
    VALID_REPORT_STATUS = 1
    MALFORMED_REPORT_STATUS = 2
    INVALID_ACCOUNT_NUMBER_REPORT_STATUS = 3
    INVALID_PASSWORD_REPORT_STATUS = 4
    INVALID_REQUEST_TYPE_STATUS = 5
    INVALID_TRANSACTION_ID_REQUEST_STATUS = 6
    INVALID_PASSWORD_OR_ACCOUNT_NUMBER_REQUEST_STATUS = 7
    TRANSACTION_NOT_FOUND_REQUEST_STATUS = 8
    
    def initialize(transaction_id = nil)
      @items = []
      if transaction_id
        obtain_status_report_data_for transaction_id
      end
    end
    
    def valid_report?
      report_status == VALID_REPORT_STATUS
    end
    
    def pending?
      status == PENDING_STATUS
    end
    
    def completed?
      status == ACCREDITED_STATUS
    end
    
    def cancelled?
      status == CANCELLED_STATUS
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
      self.report_status = response_data[:estadoreporte].first.to_i
      operations = response_data[:detalle].first[:operaciones].first
      if operations
        operation = operations[:operacion].first
        self.transaction_id = operation[:id].first.to_i
        self.date = DateTime.parse operation[:fecha].first
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
        items_data = operation[:items].first[:item]
        items_data.each do |item_data|
          item = Item.new
          item.description = item_data[:descripcion].first
          item.currency = item_data[:moneda].first.to_i
          item.unit_price = item_data[:preciounitario].first.to_f
          item.count = item_data[:cantidad].first.to_i
          self.items << item
        end
      end
    end
    
  end
end