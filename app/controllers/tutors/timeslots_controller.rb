class Tutors::TimeslotsController < ApplicationController
  before_action :authenticate_tutor!

  def new
    @min = Date.today
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy
    respond_to do |format|
      format.html { redirect_to '/tutors/timeslots/show', alert: 'Timeslot destroyed.' }
      format.json { head :no_content }
    end

  end

  def show
    @timeslots = current_tutor.timeslots.all
  end

  def create
    s = Timeslot.new
    d = params[:sdate].to_datetime.change(hour: params[:shour].to_i, min: params[:smin].to_i)
    e = params[:fdate].to_datetime.change(hour: params[:fhour].to_i, min: params[:fmin].to_i)
    s.slot_start = d.utc
    s.slot_finish = e.utc
    s.tutor_id = current_tutor.id
    if s.is_unique(current_tutor.id)
      s.save!
      respond_to do |format|
        format.html { redirect_to '/tutors/timeslots/show', alert: 'Timeslot created.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/tutors/timeslots/show', alert: 'Something went wrong.' }
        format.json { head :no_content }
      end
    end
  end

end
