class Text

  attr_accessor :code
  attr_accessor :pin_code
  attr_accessor :hour_from
  attr_accessor :min_from
  attr_accessor :hour_to
  attr_accessor :min_to
  attr_accessor :day_from
  attr_accessor :day_to

  CODES = {"O" => "OFF", "W" => "Work", "S" => "Sick", "T" => "Training", "DEL" => "Deletion"}

  def initialize
    @pin_code = '52226'

    t = Time.now
    @time = t-t.sec - t.min%15*60 + 15*60

    @hour_from = @time.hour
    @min_from = @time.min

    time_to = @time+(60*60*Settings.def_hours.to_f)
    @hour_to = time_to.hour
    @min_to = time_to.min
  end

  def sms_message
    if quick_fire?
      "#{@pin_code} #{code}"
    else
      "#{@pin_code} #{date_from.strftime("%d%m%y")} #{date_from.strftime("%H%M")} #{date_to.strftime("%d%m%y")} #{date_to.strftime("%H%M")} #{code}"
    end
  end

  def sanity
    user = "#{display_name}: " if display_name
    "#{user}Booking #{CODES[code] || code} from #{date_from.strftime("%H%M")} #{sanity_day date_from} until #{date_to.strftime("%H%M")} #{sanity_day date_to}"
  end

  def dates_wonky?
    date_from >= date_to
  end

  # def display_name
  #   Settings.pin_codes.count > 1 ? @pin_code.name : nil
  # end

  def sanity?
    !quick_fire? && Settings.sanity?
  end

  def sanity_day(in_date)

    s_day = in_date.yday
    today = Time.now.yday
    s_day += 365 if s_day < today
    case s_day - today
    when 0
      "today"
    when 1
      "tomorrow"
    when 2
      "the day after tomorrow"
    else
      in_date.strftime("%e %B")
    end
  end

  def quick_fire?
    ['ON', 'OFF'].include? code
  end

  def full_message(in_code)
    sanity + "\n\n" + sms_message(in_code)
  end

  def date_from
    from_hours = hour_from.to_f + min_from.to_f/60
    now_hours = @time.hour.to_f + @time.min.to_f/60
    diff_hours = from_hours - now_hours
    if day_from
      date = date_today.delta(days:day_from)
      Time.new(date.year, date.month, date.day, hour_from, min_from*15)
    else
      if diff_hours < -0.25
        @time + (3600 * (24 + diff_hours))
      else
        @time + (3600 * diff_hours)
      end
    end
  end

  def date_to
    to_hours = hour_to.to_f + min_to.to_f/60
    then_hours = date_from.hour.to_f + date_from.min.to_f/60
    diff_hours = to_hours - then_hours
    if day_to
      date = date_today.delta(days:day_to)
      Time.new(date.year, date.month, date.day, hour_to, min_to*15)
    else
      if diff_hours <= 0
        date_from + (3600 * (24 + diff_hours))
      else
        date_from + (3600 * diff_hours)
      end
    end
  end

  def from_datepicker_title
    if day_from
      "From: #{(Time.now+(day_from*3600*24)).strftime("%e %B")}"
    else
      "From: #{sanity_day(date_from).capitalize}"
    end
  end

  def to_datepicker_title
    if day_to
      "To: #{(Time.now+(day_to*3600*24)).strftime("%e %B")}"
    else
      "To: #{sanity_day(date_to).capitalize}"
    end
  end

  def date_today
    Time.new.start_of_day
  end

end