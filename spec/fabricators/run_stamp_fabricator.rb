Fabricator(:run_stamp) do
  userId "1"
  timeStart {Time.now}
  timeStop {Time.now + 3300}
  reason "trying"
  jobNumber "100-1"
end
