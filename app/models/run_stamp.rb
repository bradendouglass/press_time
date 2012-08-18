class RunStamp < ActiveRecord::Base
  attr_accessible :jobNumber, :reason, :timeStart, :timeStop, :userId
  validates :jobNumber, :presence => true
end
