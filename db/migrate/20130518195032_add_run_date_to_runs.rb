class AddRunDateToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :run_date, :date
    add_column :runs, :run_start_time, :time
    add_column :runs, :details, :text
    add_column :runs, :route_id, :integer

  end
end
