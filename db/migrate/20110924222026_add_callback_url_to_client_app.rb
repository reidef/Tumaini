class AddCallbackUrlToClientApp < ActiveRecord::Migration
  def change
    add_column :client_apps, :callback_url, :string
  end
end
