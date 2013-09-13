class PaymentsController < ApplicationController
  before_filter :prevent_payment_for_paid_user
  before_filter :load_plan
  before_filter :load_payment

  def paypal_callback
    if @payment.save_with_paypal_payment(payment_params) && @payment.completed?
      flash[:notice] = "Thank you for payment!"
    else
      flash[:error] = "Incomplete payment. " << @payment.errors.full_messages.join("")
    end
    redirect_to pricing_plans_path
  end

  def paypal_checkout
    redirect_to @payment.paypal.checkout_url(
                    return_url: paypal_callback_payments_url(:plan_id => @plan.id),
                    cancel_url: root_url
                )
  end

  private
  def payment_params
    {
      :paypal_customer_token => params[:PayerID],
      :paypal_payment_token => params[:token],
      :user => current_user
    }
  end

  def load_plan
    @plan = PricingPlan.find(params[:plan_id])
  end

  def load_payment
    @payment = @plan.payments.build
  end

  def prevent_payment_for_paid_user
    if current_user.paid?
      redirect_to :root, :flash => {:alert => "You have already paid"}
    end
  end
end
