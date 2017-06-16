module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current

    def connect
      self.current = find_verified
      logger.add_tags 'ActionCable', current.class, current.id
    end

    protected

      def find_verified
        if current_user = env['warden'].user(:user)
          current_user
        elsif current_tutor = env['warden'].user(:tutor)
          current_tutor
        else
          reject_unauthorized_connection
        end
      end

  end
end
