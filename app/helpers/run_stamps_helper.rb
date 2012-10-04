module RunStampsHelper
  def time_at(time)
    Time.at(time).utc.strftime("%I:%M %p - %b %d, %Y")
  end
  def time_diff(stopTime, startTime)
    diffTime = stopTime - startTime
    Time.at(diffTime).utc.strftime("(%H) hours (%M) min (%S) seconds")
  end
end
