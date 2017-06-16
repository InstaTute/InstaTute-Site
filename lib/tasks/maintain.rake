namespace :maintain do
  desc "Runs every 15 minutes, implementing rating lock, and processing funds."

  task run_all: :environment do
    Rake::Task['maintain:user_rate_lock'].invoke
    Rake::Task['maintain:process_funds'].invoke
    Rake::Task['maintain:del_old_sessions'].invoke
  end

  task user_rate_lock: :environment do
    Session.where(['finish <= ?', DateTime.now]).find_each do |s|
      user = User.where(id => s.user_id)
      user.rate_lock = true
      user.save
    end
  end

  task process_funds: :environment do
    Session.where(['finish <= ?', DateTime.now]).find_each do |s|
      user = User.where(id => s.user_id)
      tutor = Tutor.where(id => s.tutor_id)


      if tutor.stripe_id.exists?
        if tutor.session_count == 10
          service += 1
        end
        if service == 0
          amount = 20 * (s.length/60)
        elsif service == 1
          amount = 25 * (s.length/60)
        end
          user.pay(amount,tutor.stripe_id)
          tutor.session_count +=  1
      end

    end
  end

  task del_old_sessions: :environment do
    # Session.destroy_all(['finish <= ?', DateTime.now])
    Session.where(['finish <= ?', DateTime.now]).find_each do |s|
      user = User.where(id => s.user_id)
      unless user.rate_lock
        s.delete
      end
    end
  end

end
