require 'time_diff'

module RunStampsHelper
  def time_at(time)
    time = nil_time(time)
    Time.at(time).asctime
  end

  def time_diff(stopTime, startTime)
    cleanStart = nil_time(startTime)
    cleanStop = nil_time(stopTime)
    time_differance = Time.diff(Time.at(cleanStart), Time.at(cleanStop))
    "#{time_differance[:hour]} Hour(s), #{time_differance[:minute]} Minute(s), and #{time_differance[:second]} Second(s)"
  end

  def nil_time(time)
    if time == nil
      time = 0
    end
    time
  end
end
