# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # options
    # :start_date, sets the time to measure against, defaults to now
    # :date_format, used with <tt>to_formatted_s<tt>, default to :default
    def vague_timeago(time, options = {})
      start_date = options.delete(:start_date) || Time.new
      date_format = options.delete(:date_format) || :default
      delta_minutes = (start_date.to_i - time.to_i).floor / 60
      if delta_minutes.abs <= (8724*60) # eight weeks… I'm lazy to count days for longer than that
        distance = distance_of_time_in_words(delta_minutes);
        if delta_minutes < 0
          "#{distance} from now"
        else
          "#{distance} ago"
        end
      else
        return "on #{system_date.to_formatted_s(date_format)}"
      end
    end

    def distance_of_time_in_words(minutes)
      case
        when minutes < 1
          "less than a minute"
        when minutes < 50
          pluralize(minutes, "minute")
        when minutes < 90
          "about one hour"
        when minutes < 1080
          "#{(minutes / 60).round} hours"
        when minutes < 1440
          "one day"
        when minutes < 2880
          "about one day"
        else
          "#{(minutes / 1440).round} days"
      end
    end
    
    # options
    # :start_date, sets the time to measure against, defaults to now
    # :later, changes the adjective and measures time forward
    # :round, sets the unit of measure 1 = seconds, 2 = minutes, 3 hours, 4 days, 5 weeks, 6 months, 7 years (yuck!)
    # :max_seconds, sets the maximimum practical number of seconds before just referring to the actual time
    # :date_format, used with <tt>to_formatted_s<tt>
    def timeago(original, options = {})
      start_date = options.delete(:start_date) || Time.now
      later = options.delete(:later) || false
      round = options.delete(:round) || 7
      max_seconds = options.delete(:max_seconds) || 32556926
      date_format = options.delete(:date_format) || :default

      # array of time period chunks
      chunks = [
        [60 * 60 * 24 * 365 , "year"],

        [60 * 60 * 24 * 30 , "month"],
        [60 * 60 * 24 * 7, "week"],
        [60 * 60 * 24 , "day"],
        [60 * 60 , "hour"],
        [60 , "minute"],
        [1 , "second"]
      ]

      if later
        since = original.to_i - start_date.to_i
      else
        since = start_date.to_i - original.to_i
      end
      time = []

      if since < max_seconds
        # Loop trough all the chunks
        totaltime = 0

        for chunk in chunks[0..round]
          seconds    = chunk[0]
          name       = chunk[1]

          count = ((since - totaltime) / seconds).floor
          time << pluralize(count, name) unless count == 0

          totaltime += count * seconds
        end

        if time.empty?
          "less than a #{chunks[round-1][1]} ago"
        else
          "#{time.join(', ')} #{later ? 'later' : 'ago'}"
        end
      else
        original.to_formatted_s(date_format)
      end
    end
  
end
