class AddRunIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :run_id, :integer
    add_index :activities, :run_id
  end
end
