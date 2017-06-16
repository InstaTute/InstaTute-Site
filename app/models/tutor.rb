class Tutor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses
  has_many :sessions
  has_many :timeslots
  has_many :messages, as: :messageable
  has_one :chatroom
  has_many :notifications

  def create_account(email,city,line1,zip,state,bday,bmonth,byear,first_name,last_name,ssn_last_4,bank_token,ip,timestamp)

    require 'stripe'

    Stripe.api_key = ENV['stripe_api_key']
    tutor = Stripe::Account.create(
      {
        :country => "US",
        :managed => true,
        :email => email,
        :external_account => bank_token,
        :default_currency => "USD",
        :legal_entity => {
          :address => {
            :city => city,
            :country => "US",
            :line1 => line1,
            :postal_code => zip,
            :state => state
          },
          :dob => {
            :day => bday,
            :month => bmonth,
            :year => byear
          },
          :first_name => first_name,
          :last_name => last_name,
          :ssn_last_4 => ssn_last_4,
          :type => "individual"
        },
        :tos_acceptance => {
          :date => timestamp,
          :ip => ip
        },
        :transfer_schedule => {
          :interval => "weekly",
          :weekly_anchor => "sunday"
        }
      }
    )

    self.stripe_id = tutor.id
    self.save!

    return true

  end

end
