class UsersController < ApplicationController
before_action :authenticate_user!
before_action :rate_locked, only: [:new_session, :request_session, :new_chat]

  def index
    if current_user.rate_lock
      respond_to do |format|
        format.html { redirect_to '/users/rate', alert: 'Please rate your last session. Your account will be locked till you do so.' }
        format.json { head :no_content }
      end
    end
  end

  def rate
    unless current_user.rate_lock
      redirect_to '/users/index'
    end
    @user = current_user
  end

  def new_chat
    @subjects = Subject.all
  end

  def new_session
    @subjects = Subject.all
    @min = Date.today
    @max = Date.today + 2.days
  end

  def request_session
    @subjects = Subject.all
    @min = Date.today
    @max = Date.today + 2.days

    first_set = []
    final_set = []

    service = params[:service].to_i
    course_name = params[:course_name]
    start = params[:date].to_datetime
    start = start.change({ hour: params[:hour].to_i, min: params[:min].to_i })
    time = params[:time].to_i
    finish = start + (time*60)
    topic = params[:topic]
    puts topic
    location = params[:location]

    if Tutor.exists?(service: service, setup: true)


      Tutor.where(service: service, setup: true).find_each do |tutor|
        if tutor.courses.exists?(name: course_name)
          first_set.push(tutor)
        end
      end

      if first_set.empty?
        respond_to do |format|
          format.html { redirect_to '/users/new_session', alert: 'There are no tutors available based on the parameters you have entered. Please try again!' }
          format.json { head :no_content }
        end
      else
        first_set.each do |tutor|
          i = 0
          tutor.timeslots.each do |slot|
            puts slot
            puts start.to_datetime.utc
            puts finish.to_datetime.utc
            puts slot.slot_start.to_datetime.utc
            puts slot.slot_finish.to_datetime.utc
            if slot.available(start, finish)
              puts 'ok'
              i+=1
            end
          end
          if i>0
            final_set.push(tutor)
          end
        end
      end

      puts final_set.sample

      if final_set.empty?
        respond_to do |format|
          format.html { redirect_to '/users/new_session', alert: 'There are no tutors available based on the parameters you have entered. Please try again!' }
          format.json { head :no_content }
        end
      else
        selected = final_set.sample
        @sesh = Session.new()
        @sesh.user_id = current_user.id
        @sesh.tutor_id = selected.id
        @sesh.start = start
        @sesh.length = time
        @sesh.finish = finish
        @sesh.course_id = Course.find_by(:name => course_name).id
        @sesh.topic = topic
        @sesh.location = location
        @sesh.save!

        selected.timeslots.find_each do |t|
          if t.available(start,finish)
            t.destroy!
          end
        end

        @user = current_user
        @user.last_tutor_id = selected.id
        @user.save!

        selected.session_count += 1
        selected.save!

        TutorMailer.reg_session_notification(selected,@user,@sesh).deliver

        UserMailer.reg_session_notification(selected,@user,@sesh).deliver

        respond_to do |format|
          format.html { redirect_to '/users/index', alert: 'Session created. Please check your email for confirmation.' }
          format.json { head :no_content }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to '/users/new_session', alert: 'There are no tutors available based on the parameters you have entered. Please try again!' }
        format.json { head :no_content }
      end
    end

  end

  protected

    def rate_locked
      if current_user.rate_lock
        respond_to do |format|
          format.html { redirect_to '/users/rate', alert: 'Please rate your last session. Your account will be locked till you do so.' }
          format.json { head :no_content }
        end
      end
    end

end
