class ChangeTimeStartColumnRunStampsToNumber < ActiveRecord::Migration
  def up
    change_column :run_stamps, :timeStart, :integer
    change_column :run_stamps, :timeStop, :integer
  end

  def down
  end
end
