# frozen_string_literal: true

class AddRoleReferenceToUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference_concurrently :users, :role, null: false, foreign_key: true
  end
end
