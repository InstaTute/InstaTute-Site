class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def add_tutor
    @tutor = Tutor.new(:email => params[:email], :password => params[:pass], :password_confirmation => params[:pass])
    @tutor.save!
    # Email new tutor
  end
  def new_tutor
  end
end
