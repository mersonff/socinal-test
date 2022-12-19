# frozen_string_literal: true

class CreateExecutions < ActiveRecord::Migration[7.0]
  def change
    safety_assured do
      create_table :executions do |t|
        t.references :user, null: false, foreign_key: true
        t.references :task, null: false, foreign_key: true

        t.timestamps
      end
    end
  end
end
