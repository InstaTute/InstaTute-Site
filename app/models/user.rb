class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sessions
  has_and_belongs_to_many :courses
  has_many :messages, as: :messageable
  has_one :chatroom

  validate :colgate_check

  def add_customer(token)
    require 'stripe'
    Stripe.api_key = ENV['stripe_api_key']

    customer = Stripe::Customer.create(
    :source => token,
    :description => "InstaTute Customer",
    :email => self.email
    )
    self.stripe_id = customer.id
    self.save!

  end

  def pay(amount,tutor_stripe_id)
    require 'stripe'
    Stripe.api_key = ENV['stripe_api_key']

    if amount < 100
      amount = 100
    end

    Stripe::Charge.create(
    :amount => amount, # in cents
    :currency => "usd",
    :customer => self.stripe_id,
    :destination => tutor_stripe_id,
    :application_fee => 100
    )

  end

  private

  def colgate_check
    e = self.email
    if (Swot::school_name(e) != "Colgate University")
      errors.add(:email, "Sorry, but right now we're only opening accounts to students from Colgate University.")
    end
  end

end
