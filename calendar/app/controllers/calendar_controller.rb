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

  def create_event(buffer)
      cal = RiCal.Calendar do |cal|
        buffer.each do |line|
          cal.event do |event|
            event.summary     = line[0]
            #event.description = "First US Manned Spaceflight\n(NASA Code: Mercury 13/Friendship 7)"
            event.dtstart     = Time.parse(line[1]).getutc
            event.dtend       = Time.parse(line[2]).getutc
            #event.location    = "Cape Canaveral"
            #event.add_attendee  "john.glenn@nasa.gov"
            #event.url         = "http://nasa.gov"
          end
        end
      end
    return cal
  end

  def ical
      @ical = Array.new
      buffer = recup_content
      @ical << create_event(buffer)
      File.open('calendar.ics', 'w') do |filea|
        @ical.each do |line|
         filea.puts line
        end
      end
  end
end
