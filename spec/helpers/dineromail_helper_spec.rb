require 'spec_helper'
require 'rspec/rails'
require 'rspec/rails/views/matchers'

describe DineromailHelper do
  describe "#dineromail_button" do
    it 'should create a form with hidden fields' do
      generated_html = helper.dineromail_button('item name',9.56)
      generated_html.should have_tag('form') do
        with_tag "input", :with => { :name => 'NombreItem', :type => 'hidden', :value => 'item name' }
        with_tag "input", :with => { :name => 'PrecioItem', :type => 'hidden', :value => '9.56' }
      end
    end
  end
  
  describe "#dineromail_inputs" do
    it 'should create hidden fields without a form' do
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should_not have_tag('form')
      generated_html.should have_tag('input', :with => {:type => 'hidden'})
    end
    
    it 'should accept a transaction_id option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :transaction_id => '1234567')
      generated_html.should have_tag('input', :with => {:name => 'TRX_ID', :type => 'hidden', :value => '1234567'})
    end
    
    it 'should accept a logo_url option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :logo_url => 'http://test.com')
      generated_html.should have_tag('input', :with => {:name => 'image_url', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should accept a return_url option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :return_url => 'http://test.com')
      generated_html.should have_tag('input', :with => {:name => 'DireccionExito', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should accept an error_url option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :error_url => 'http://test.com')
      generated_html.should have_tag('input', :with => {:name => 'DireccionFracaso', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should accept a message option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :message => true)
      generated_html.should have_tag('input', :with => {:name => 'Mensaje', :type => 'hidden', :value => '1'})
      generated_html = helper.dineromail_inputs('item name',9.56, :message => false)
      generated_html.should have_tag('input', :with => {:name => 'Mensaje', :type => 'hidden', :value => '0'})
    end
    
    it 'should accept an account_number option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :account_number => '1234567')
      generated_html.should have_tag('input', :with => {:name => 'E_Comercio', :type => 'hidden', :value => '1234567'})
    end
    
    it 'should accept a pay_methods option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :pay_methods => '1')
      generated_html.should have_tag('input', :with => {:name => 'MediosPago', :type => 'hidden', :value => '1'})
    end
    
    it 'should accept a currency option' do
      currency = Dineromail::Configuration::PESO
      generated_html = helper.dineromail_inputs('item name',9.56, :currency => currency)
      generated_html.should have_tag('input', :with => {:name => 'TipoMoneda', :type => 'hidden', :value => currency.to_s})
    end
    
    it 'should accept an item_number option' do
      generated_html = helper.dineromail_inputs('item name',9.56, :item_number => '1')
      generated_html.should have_tag('input', :with => {:name => 'NroItem', :type => 'hidden', :value => '1'})
    end
    
    it 'should read logo_url from configuration if no value is given' do
      Dineromail.configure do |c|
        c.logo_url = 'http://test.com'
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'image_url', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should read return_url from configuration if no value is given' do
      Dineromail.configure do |c|
        c.return_url = 'http://test.com'
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'DireccionExito', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should read error_url from configuration if no value is given' do
      Dineromail.configure do |c|
        c.error_url = 'http://test.com'
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'DireccionFracaso', :type => 'hidden', :value => 'http://test.com'})
    end
    
    it 'should read account_number from configuration if no value is given' do
      Dineromail.configure do |c|
        c.account_number = '1234567'
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'E_Comercio', :type => 'hidden', :value => '1234567'})
    end
    
    it 'should read pay_methods from configuration if no value is given' do
      Dineromail.configure do |c|
        c.pay_methods = '1'
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'MediosPago', :type => 'hidden', :value => '1'})
    end
    
    it 'should read currency from configuration if no value is given' do
      currency = Dineromail::Configuration::PESO
      Dineromail.configure do |c|
        c.currency = currency
      end
      
      generated_html = helper.dineromail_inputs('item name',9.56)
      generated_html.should have_tag('input', :with => {:name => 'TipoMoneda', :type => 'hidden', :value => currency.to_s})
    end
    
  end
end

