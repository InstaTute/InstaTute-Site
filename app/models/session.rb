class Session < ApplicationRecord
  belongs_to :course
  belongs_to :tutor
  belongs_to :user

  def meeting_notify
    @calendar = Icalendar::Calendar.new
    event = Icalendar::Event.new
    event.start = self.start.strftime("%Y%m%dT%H%M%S%Z")
    event.end = self.finish.strftime("%Y%m%dT%H%M%S%Z")
    event.summary = self.
    event.description = self.event.topic.description
    event.location = self.event.location
    @calendar.add event
    @calendar.publish

    file = File.new(Rails.root.join('tmp').to_s << "/ics_files/cal.ics", "w+")
    file.write(@calendar.to_ical)
    file.close



  end
end
