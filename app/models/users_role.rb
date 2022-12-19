class User < ApplicationRecord
  has_many :users_roles, dependent: :destroy
  has_many :roles, through: :users_roles
  has_many :executions, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true
end
