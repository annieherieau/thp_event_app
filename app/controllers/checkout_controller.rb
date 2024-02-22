class CheckoutController < ApplicationController
  # création du paiement stripe
  def create
    @event = Event.find(params[:event_id])
    @amount = @event.price.to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@amount*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        event_id: @event.id
      },
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url(event_id: @event.id)
    )
    redirect_to @session.url, allow_other_host: true
  end

  # payment succes + création de l'attenance
  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @event_id = @session.metadata.event_id
    @user = current_user
    AttendancesController.new.create(@user.id, @event_id)
  end

  # payment failed
  def cancel
    @event = Event.find(params[:event_id])
  end
end
