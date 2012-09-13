class ChangeTimeStartColumnRunStampsToNumber < ActiveRecord::Migration
  def up
    change_column :run_stamps, :timeStart, :integer
    change_column :run_stamps, :timeStop, :integer
  end

  def down
    change_column :run_stamps, :timeStart, :time
    change_column :run_stamps, :timeStop, :time
  end
end
