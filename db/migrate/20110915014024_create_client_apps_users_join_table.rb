class CreateClientAppsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :client_apps_users, :id => false do |t|
      t.integer :client_app_id
      t.integer :user_id
    end
  end
end
