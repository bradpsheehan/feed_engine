class CreateTableUserRuns < ActiveRecord::Migration
  def change
    create_table :user_runs do |t|
      t.integer :run_id
      t.integer :user_id
      t.string  :status
      t.timestamps
    end
  end
end
