class OrderTransaction < ActiveRecord::Base
  # Initializes a new instance of ActiveMerchant 
  # payment gateway
  cattr_accessor :gateway

  # Serializes the Response#params returned from ActiveMerchant
  # payment gateway and stores them in the database.
  serialize :params

  belongs_to :order

  validates_presence_of :amount, :action, :params

  class << self
    
    def authorize(amount, credit_card, options={})
      process('authorization', amount, options) do |gw|
        gw.authorize(amount, credit_card, options)
      end
    end
    
    def capture(amount, authorization, options={})
      process('capture', amount, options) do |gw|
        gw.capture(amount, authorization, options)
      end
    end
    
    def purchase(amount, credit_card, options={})
      process('purchase', amount, options) do |gw|
        gw.purchase(amount, credit_card, options)
      end
    end
    
    private
    
    def process(action, amount=nil, options={})
      result        = OrderTransaction.new
      result.amount = amount
      result.action = action
      
      begin
        response = yield(gateway)
        
        result.success   = response.success?
        result.reference = response.authorization
        result.message   = response.message
        result.params    = response.params
        result.test      = response.test?
      rescue ActiveMerchant::ActiveMerchantError => e
        result.success   = false
        result.reference = nil
        result.message   = e.message
        result.params    = {}
        result.test      = gateway.test?
      end
      
      result
    end
  end
  
end
