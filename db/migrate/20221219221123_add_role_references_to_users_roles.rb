class AddRoleReferencesToUsersRoles < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  
  def change
    add_reference_concurrently :users_roles, :role, null: false, foreign_key: true
  end
end
