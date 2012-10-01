module RunStampsHelper
  def time_at(time)
    Time.at(time).utc.strftime("%I:%M %p - %b %d, %Y")
  end
  def time_diff(stopTime, startTime)

  end
end
