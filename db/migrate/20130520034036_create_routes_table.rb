class CreateRoutesTable < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.text :path
      t.timestamps
    end
  end
end
