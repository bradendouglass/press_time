class CreateRunStamps < ActiveRecord::Migration
  def change
    create_table :run_stamps do |t|
      t.integer :userId
      t.time :timeStart
      t.time :timeStop
      t.string :jobNumber
      t.string :reason

      t.timestamps
    end
  end
end
