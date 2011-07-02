require 'spec_helper'
require 'rspec/rails'
require 'rspec/rails/views/matchers'

describe DineromailHelper do
  describe "#dineromail_button" do
    it 'should create a form with hidden fields' do
      generated_html = helper.dineromail_button('item name',9.56)
      generated_html.should have_tag('form') do
        with_tag "input", :with => { :name => 'NombreItem', :type => 'hidden', :value => 'item name' }
      end
    end
  end
end

