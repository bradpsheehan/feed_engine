class AddLargePhotoUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :large_photo_url, :string
  end
end
