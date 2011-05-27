require 'dineromail/version'
require 'dineromail/notification'
require 'dineromail/status_report'
require 'dineromail/buyer'
require 'dineromail/configuration'

module Dineromail
  self.configure do |config|
    #Default confiuration
    config.ipn_url = 'https://argentina.dineromail.com/Vender/Consulta_IPN.asp'
  end
end
