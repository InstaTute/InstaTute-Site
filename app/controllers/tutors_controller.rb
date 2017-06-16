class TutorsController < ApplicationController
  before_action :authenticate_tutor!, :except => [:rate]
  before_action :chat_not_ready, :except => [:rate]

  def index
    @tutor = current_tutor
  end

  def rate
    new_rate = params[:rate].to_i
    tutor = Tutor.find(params[:tutor])
    unless tutor.nil?
      if (tutor.rating == 0 || tutor.rating == nil)
        tutor.rating = new_rate
        tutor.save!
      else
        tutor.rating = (tutor.rating + new_rate)/2
        tutor.save!
      end
      user = current_user
      user.rate_lock = false
      user.save!
      unless params[:review].nil?
        ReviewMailer.review(params[:review],user,tutor).deliver
      end
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Success! You have successfully rated your last tutor. The lock on your account has been lifted.' }
        format.json { head :no_content }
      end
    end
  end

  def account
  end

  def payment
    email = params[:email]
    city = params[:city]
    line1 = params[:address]
    zip = params[:zip]
    state = params[:state]
    bday = params[:bday]
    bmonth = params[:bmonth]
    byear = params[:byear]
    first_name = params[:first_name]
    last_name = params[:last_name]
    ssn_last_4 = params[:ssn_last_4]
    bank_token = params[:stripeToken]
    ip = request.remote_ip
    timestamp = Time.now.to_i

    @tutes = current_tutor

    if @tutes.create_account(email,city,line1,zip,state,bday,bmonth,byear,first_name,last_name,ssn_last_4,bank_token,ip,timestamp)
      @tutes.setup = true
      @tutes.first_name = first_name
      @tutes.last_name = last_name
      @tutes.session_count = 0
      @tutes.rating = 0
      @tutes.save!
      redirect_to root_path
    else
      respond_to do |format|
        format.html { redirect_to '/tutors/account', alert: 'Sorry, but something went wrong. Please try again.' }
        format.json { head :no_content }
      end
    end
  end

  protected
    def chat_not_ready
      current_tutor.chat_ready = false
      current_tutor.save!
    end
end
