require 'spec_helper'

describe Dineromail::Notification do
  it 'should load the notifications from the notification xml' do
    notification_xml = '<NOTIFICACION><TIPONOTIFICACION>1</TIPONOTIFICACION><OPERACIONES><OPERACION><TIPO>1</TIPO><ID>31548</ID></OPERACION><OPERACION><TIPO>1</TIPO><ID>XA5547</ID></OPERACION></OPERACIONES></NOTIFICACION>'
    notifications = Dineromail::Notification.from_xml(notification_xml)
    notifications.count.should == 2
    notifications.first.transaction_id.should == '31548'
    notifications.last.transaction_id.should == 'XA5547'
  end
  
  
  
end
