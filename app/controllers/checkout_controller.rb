class CheckoutController < ApplicationController
  def create
    # ajouter une sécurité pour attendance uniqueness ?
    @user = current_user
    @product = Event.find(params[:event_id])
    @amount = @product.price.to_d
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
        metadata: {
          event_id: @event_id
        },
      ],
      mode: 'payment',
      success_url: 'http://localhost:3000' + checkout_success_path(event_id: @product.id) + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://localhost:3000' + checkout_cancel_path
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @user = current_user
    @event = Event.find(params[:event_id])
    @session_id = params[:session_id]
    @attendance = Attendance.new(
      user: @user,
      event: @event,
      stripe_customer_id: @session_id
    )
    if @attendance.save
      puts '#'*20
      puts 'Attendance ok'
    else
      puts '#'*20
      puts 'Attendance NON ok'
    end
  end

  def cancel
  end
end
