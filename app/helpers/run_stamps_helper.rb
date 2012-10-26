module RunStampsHelper
  def time_at(time)
    time = nil_time(time)
    Time.at(time).asctime
  end

  def time_diff(stopTime, startTime)
    cleanStart = nil_time(startTime)
    cleanStop = nil_time(stopTime)
    "#{ cleanStop - cleanStart } Seconds"
  end


  def nil_time(time)
    if time == nil
      time = 0
    end
    time
  end
end
