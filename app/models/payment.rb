class Payment < ActiveRecord::Base
  validates :pricing_plan, :user, :paypal_customer_token, :presence => true

  belongs_to :pricing_plan
  belongs_to :user

  attr_accessor :paypal_payment_token

  after_create :update_user_info

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment(payment_params)
    self.assign_attributes(payment_params)
    if valid? && paypal_payment_token.present?
      response = paypal.make_payment
      self.completed = response.completed?
      save
    end
  end

  private
  def update_user_info
    if self.completed?
      self.user.update_attributes(:expired_at => Date.today + self.pricing_plan.duration.months)
    end
  end
end
