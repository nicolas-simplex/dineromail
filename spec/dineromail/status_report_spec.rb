require 'spec_helper'
require 'rspec/rails'
require 'rspec/rails/views/matchers'

describe Dineromail::StatusReport do
  it 'should load the status report from xml' do
    xml = File.read( 'spec/fixtures/status_report.xml')
    
    status_report = Dineromail::StatusReport.parse(xml)
    operation = status_report.operations.first
    buyer = operation.buyer
    item = operation.items.first
    
    status_report.report_status.should == 1
    status_report.valid_report?.should be_true
    operation.transaction_id.should == 1889
    operation.date.should == DateTime.ordinal(2011,28,12,2,1)
    operation.status.should == Dineromail::Operation::PENDING_STATUS
    operation.pending?.should be_true
    operation.completed?.should be_false
    operation.cancelled?.should be_false
    operation.amount.should == 60.2
    operation.net_amount.should == 50.3
    operation.pay_method.should == 'TARJETA DE CREDITO'
    operation.pay_medium.should == 'VISA'
    buyer.email.should == 'comprador@email.com'
    buyer.address.should == 'San Martin 10'
    buyer.comment.should == 'comentario'
    buyer.name.should == 'Juan'
    buyer.phone.should == '4444444'
    buyer.document_type.should == 'DNI'
    buyer.document_number.should == '222222222'
    item.description.should == 'Libro'
    item.currency.should == Dineromail::Configuration::PESO
    item.count.should == 2
    item.unit_price.should == 6.9
  end
  
  it 'should use the configuration to get the parameters for the request if no options are given' do
    transaction_id = 42
    Dineromail.configure do |c|
      c.account_number = '10000'
      c.password = 'password-123'
    end
    xml_request = Dineromail::StatusReport.xml_request_for(transaction_id)
    xml_request.should have_tag('nrocta', :text => '10000')
    xml_request.should have_tag('clave', :text => 'password-123')
    xml_request.should have_tag('id', :text => '42')
  end
  
  it 'should use the option parameters for the request if options are given' do
    transaction_id = 42
    Dineromail.configure do |c|
      c.account_number = '10000'
      c.password = 'password-123'
    end
    xml_request = Dineromail::StatusReport.xml_request_for(transaction_id,{:account_number => '2000',:password => 'password-456'})
    xml_request.should have_tag('nrocta', :text => '2000')
    xml_request.should have_tag('clave', :text => 'password-456')
    xml_request.should have_tag('id', :text => '42')
  end
  
end
