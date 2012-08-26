class RunStamp < ActiveRecord::Base
  attr_accessible :jobNumber, :reason, :timeStart, :timeStop, :userId
  validates :jobNumber,
    :presence => true

  private
  def self.halt_reasons
    {'Something Awesome' => '1',
    'Something Marginally Awesome' => '2'}
  end
end
