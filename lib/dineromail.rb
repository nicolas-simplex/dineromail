require 'dineromail/version'
require 'dineromail/notification'
require 'dineromail/buyer'
require 'dineromail/operation'
require 'dineromail/item'
require 'dineromail/status_report'
require 'dineromail/configuration'
require 'dineromail/app/helpers/dineromail_helper'
require 'action_controller'

module Dineromail
  self.configure do |config|
    #Default confiuration
    config.ipn_webservice_url = 'https://argentina.dineromail.com/Vender/Consulta_IPN.asp'
    config.currency = 1
    config.pay_methods = '' #Todos
    config.payment_url = 'https://argentina.dineromail.com/Shop/Shop_Ingreso.asp'
    config.button_image_url = 'https://argentina.dineromail.com/imagenes/vender/boton/comprar-gris.gif'
  end
end

ActionController::Base.helper(DineromailHelper)