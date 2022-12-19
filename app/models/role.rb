# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users_roles, dependent: :destroy
  has_many :users, through: :users_roles

  validates :name, uniqueness: true, presence: true
end
