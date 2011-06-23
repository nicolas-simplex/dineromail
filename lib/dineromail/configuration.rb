module Dineromail
  class Configuration
    attr_accessor :payment_url, :ipn_webservice_url, :account_number, :password,
              :logo_url, :return_url, :error_url, :pay_methods, :currency, :button_image_url
            
    PESO = 1
    DOLLAR = 2
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

end