class RunStamp < ActiveRecord::Base
  attr_accessible :jobNumber, :reason, :timeStart, :timeStop, :userId
  validates :jobNumber, :timeStart, :timeStop, :presence => true

  private
  def self.halt_reasons
    {'Set-up' => '1',
    'Start-up' => '2',
    'Bad Material' => '3',
    'Web Broke' => '4',
    'Bad Stripe' => '5',
    'Press' => '6',
    'Registration' => '7',
    'Other' => '8',
    'Bad Plate' => '9',
    'Die' => '10',
    'Rewind' => '11',
    'Power Out' => '13',
    'Lunch' => '14',
    'UV Lamps' => '15',
    'Testing' => '16',
    'Tension' => '17',
    'Chopper' => '18',
    'Numbering' => '19',
    'Web Guide' => '20',
    'Print Statn' => '21',
    'Curl' => '22',
    'KTI' => '23',
    'Filler Paper' => '24',
    'Over Runs' => '25',
    'Re Runs' => '26',
    'Foiling' => '27',
    'Folder' => '28',
    'In-Line Stripe' => '29',
    'Clean Up' => '30'
    }
  end
end
