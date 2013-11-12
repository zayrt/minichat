class CalendarController < ApplicationController
  require 'csv'

  def index
  	buff = recup_content
	  @content = buff
  end

  def recup_content
	buffer = Array.new
	if File.exist?("calendar.csv")
		CSV.foreach("calendar.csv") do | row |
			row = row.to_s.delete"[\"]"
			buffer << row.split(";")
		end
	end
  	return buffer
  end

  def create_event_rical(buffer)
      cal = RiCal.Calendar do |cal|
        buffer.each do |line|
          if !line.empty?
          cal.event do |event|
            event.summary     = line[0]
            event.dtstart     = Time.parse(line[1]).getutc
            event.dtend       = Time.parse(line[2]).getutc
          end
        end
        end
      end
    return cal
  end

  def create_event_ical(buffer)
    cal = Icalendar::Calendar.new

    buffer.each do |line|
      if !line.empty?
      event = Icalendar::Event.new
      event.dtstart =  line[1].to_time.strftime("%Y%m%d")
      event.dtend = line[2].to_time.strftime("%Y%m%d")
      event.summary = line[0]
      cal.add event
      end
    end
    return cal.to_ical
  end

  def ical
  	@ical = Array.new
      buffer = recup_content
      @ical << create_event_ical(buffer)
      ical = create_event_ical(buffer)
      File.open('calendar.ics', 'w') do |filea|
        @ical.each do |line|
          filea.puts line
        end
      end
      return ical
  end
end
