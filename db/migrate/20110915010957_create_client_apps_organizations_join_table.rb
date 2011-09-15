class CreateClientAppsOrganizationsJoinTable < ActiveRecord::Migration
  def change
    create_table :client_apps_organizations, :id => false do |t|
      t.integer :client_app_id
      t.integer :organization_id
    end
  end
end
