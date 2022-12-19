class User < ApplicationRecord
  has_and_belongs_to_many :roles, join_table: :users_roles
  has_many :executions, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true

  accepts_nested_attributes_for :roles, allow_destroy: true

  def role_for_task?(task)
    roles.any? { |role| role.id == task.role_id }
  end
end
