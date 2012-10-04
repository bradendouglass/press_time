module RunStampsHelper
  def time_at(time)
    time = nil_time(time)
    Time.at(time).utc.strftime("%I:%M %p - %b %d, %Y")
  end

  def time_diff(stopTime, startTime)
    cleanStart = nil_time(startTime)
    cleanStop = nil_time(stopTime)
    diffTime = cleanStop - cleanStart
    Time.at(diffTime).utc.strftime("(%H) hours (%M) min (%S) seconds")
  end

  def nil_time(time)
    if time == nil
      time = 0
    end
    time
  end
end
