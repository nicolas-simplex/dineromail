require 'spec_helper'

describe Dineromail::StatusReport do
  it 'should load the status report from xml' do
    xml = '<REPORTE><ESTADOREPORTE></ESTADOREPORTE><DETALLE><OPERACIONES><OPERACION>
          <ID>1889</ID>
          <FECHA>01/28/2011 12:02:01 PM</FECHA>
          <ESTADO>1</ESTADO>
          <NUMTRANSACCION>67777</NUMTRANSACCION>
          <COMPRADOR>
            <EMAIL>comprador@email.com</EMAIL>
            <DIRECCION>San Martin 10</DIRECCION>
            <COMENTARIO>comentario</COMENTARIO>
            <NOMBRE>Juan</NOMBRE>
            <TELEFONO>4444444</TELEFONO>
            <TIPODOC>DNI</TIPODOC>
            <NUMERODOC>222222222</NUMERODOC>
          </COMPRADOR>
          <MONTO>60.2</MONTO>
          <MONTONETO>50.3</MONTONETO>
          <METODOPAGO>TARJETA DE CREDITO</METODOPAGO>
          <MEDIOPAGO>VISA</MEDIOPAGO>
          <CUOTAS>1</CUOTAS>
          <ITEMS>
            <ITEM>
              <DESCRIPCION>Libro</DESCRIPCION>
              <MONEDA>1</MONEDA>
              <PRECIOUNITARIO>6.90</PRECIOUNITARIO>
              <CANTIDAD>2</CANTIDAD>
            </ITEM>
          </ITEMS><VENDEDOR><TIPODOC></TIPODOC><NUMERODOC></NUMERODOC></VENDEDOR></OPERACION></OPERACIONES></DETALLE></REPORTE>'
    
    status_report = Dineromail::StatusReport.new    
    status_report.parse_response(xml)
    buyer = status_report.buyer
    item = status_report.items.first
    
    status_report.transaction_id.should == 1889
    status_report.date.should == DateTime.ordinal(2011,28,12,2,1)
    status_report.status.should == Dineromail::StatusReport::PENDING_STATUS
    status_report.amount.should == 60.2
    status_report.net_amount.should == 50.3
    status_report.pay_method.should == 'TARJETA DE CREDITO'
    status_report.pay_medium.should == 'VISA'
    buyer.email.should == 'comprador@email.com'
    buyer.address.should == 'San Martin 10'
    buyer.comment.should == 'comentario'
    buyer.name.should == 'Juan'
    buyer.phone.should == '4444444'
    buyer.document_type.should == 'DNI'
    buyer.document_number.should == '222222222'
    item.description.should == 'Libro'
    item.currency.should == 1
    item.count.should == 2
    item.unit_price.should == 6.9
  end
end
