module Dineromail
  class Configuration
    attr_accessor :ipn_url, :account_number, :password
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

end