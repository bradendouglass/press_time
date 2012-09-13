class ChangeTimeStartColumnRunStampsToNumber < ActiveRecord::Migration
  def up
    remove_column :run_stamps, :timeStop
    remove_column :run_stamps, :timeStart
    add_column :run_stamps, :timeStart, :integer
    add_column :run_stamps, :timeStop, :integer
  end

  def down
  end
end
