class Role < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_and_belongs_to_many :users, join_table: :users_roles
end
