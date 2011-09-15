class CreateClientApps < ActiveRecord::Migration
  def change
    create_table :client_apps do |t|
      t.string :name
      t.string :api_key

      t.timestamps
    end
  end
end
