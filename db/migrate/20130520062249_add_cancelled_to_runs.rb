class AddCancelledToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :cancelled, :boolean, default: false
  end
end
