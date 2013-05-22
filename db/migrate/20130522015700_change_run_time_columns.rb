class ChangeRunTimeColumns < ActiveRecord::Migration

  def change
    remove_column :runs, :run_start_time
    remove_column :runs, :run_date
    add_column :runs, :started_at, :datetime
    add_index :runs, :started_at
  end
end
