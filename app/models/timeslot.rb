class Timeslot < ApplicationRecord
  belongs_to :tutor

  def available(start, finish)
    if ((self.slot_start.to_datetime.utc.to_i <= start.to_datetime.utc.to_i) && (self.slot_finish.to_datetime.utc.to_i >= finish.to_datetime.utc.to_i))
      return true
    elsif (self.slot_start.to_datetime.utc.to_i > start.to_datetime.utc.to_i) || (self.slot_finish.to_datetime.utc.to_i < finish.to_datetime.utc.to_i)
      return false
    end
  end

  def is_unique(tutor_id)
    Tutor.where(:id => tutor_id).sample.timeslots.find_each do |time|
      if (self.slot_start.utc - time.slot_finish.utc) * (time.slot_start.utc - self.slot_finish.utc) > 0
        return false
      end
    end
    return true
  end

end
