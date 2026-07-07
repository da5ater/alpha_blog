class AddUsersTimestamps < ActiveRecord::Migration[8.1]
  def change
    add_timestamps :users, null: true

    User.update_all(created_at: Time.current, updated_at: Time.current)
  end
end
