class AddAppUrlToClientApp < ActiveRecord::Migration
  def change
    add_column :client_apps, :app_url, :string
  end
end
