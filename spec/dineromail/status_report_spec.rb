require 'spec_helper'

describe Dineromail::StatusReport do
  it 'should load the status report from xml' do
    xml = '<REPORTE><ESTADOREPORTE></ESTADOREPORTE><DETALLE><OPERACIONES><OPERACION>
          <ID>1889</ID>
          <FECHA>17/01/2011</FECHA>
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
          <MONTO>60</MONTO>
          <MONTONETO>50</MONTONETO>
          <METODOPAGO>TARJETA DE CREDITO</METODOPAGO>
          <MEDIOPAGO>VISA</MEDIOPAGO>
          <CUOTAS>1</CUOTAS>
          <ITEMS><ITEM><DESCRIPCION></DESCRIPCION><MONEDA></MONEDA><PRECIOUNITARIO></PRECIOUNITARIO><CANTIDAD></CANTIDAD></ITEM></ITEMS><VENDEDOR><TIPODOC></TIPODOC><NUMERODOC></NUMERODOC></VENDEDOR></OPERACION></OPERACIONES></DETALLE></REPORTE>'
    
    status_report = Dineromail::StatusReport.new    
    status_report.parse_response(xml)
    buyer = status_report.buyer
    
    
    status_report.transaction_id.should == '1889'
    status_report.date.should == '17/01/2011'
    status_report.status.should == Dineromail::StatusReport::PENDING_STATUS
    status_report.amount.should == 60.0
    status_report.net_amount.should == 50.0
    status_report.pay_method.should == 'TARJETA DE CREDITO'
    status_report.pay_medium.should == 'VISA'
    buyer.email.should == 'comprador@email.com'
    buyer.address.should == 'San Martin 10'
    buyer.comment.should == 'comentario'
    buyer.name.should == 'Juan'
    buyer.phone.should == '4444444'
    buyer.document_type.should == 'DNI'
    buyer.document_number.should == '222222222'
  end
end
