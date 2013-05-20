class AddOrganizerToRun < ActiveRecord::Migration
  def change
    add_column :runs, :organizer_id, :integer
  end
end
