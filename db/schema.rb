# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_219_221_123) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'executions', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'task_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['task_id'], name: 'index_executions_on_task_id'
    t.index ['user_id'], name: 'index_executions_on_user_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_roles_on_name', unique: true
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'role_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['role_id'], name: 'index_tasks_on_role_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'nickname', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['nickname'], name: 'index_users_on_nickname', unique: true
  end

  create_table 'users_roles', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'role_id', null: false
    t.index ['role_id'], name: 'index_users_roles_on_role_id'
    t.index ['user_id'], name: 'index_users_roles_on_user_id'
  end

  add_foreign_key 'executions', 'tasks'
  add_foreign_key 'executions', 'users'
  add_foreign_key 'tasks', 'roles'
  add_foreign_key 'users_roles', 'roles'
  add_foreign_key 'users_roles', 'users'
end
