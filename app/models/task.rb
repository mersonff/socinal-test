# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :role

  has_many :executions, dependent: :destroy

  validates :name, presence: true
end
