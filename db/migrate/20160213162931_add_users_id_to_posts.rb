class AddUsersIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :intager
  end
end
