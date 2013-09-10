class PaypalPayment
  def initialize(payment)
    @payment = payment
  end

  def checkout_details
    process :checkout_details
  end
  
  def checkout_url(options)
    process(:checkout, options).checkout_url
  end
  
  def make_payment
    process :request_payment
  end
  
private

  def process(action, options = {})
    options = options.reverse_merge(
      :token => @payment.paypal_payment_token,
      :payer_id => @payment.paypal_customer_token,
      :description => @payment.pricing_plan.name,
      :amount => @payment.pricing_plan.cost,
      :currency => "USD"
    )
    response = PayPal::Recurring.new(options).send(action)
    raise response.errors.inspect if response.errors.present?
    response
  end
end