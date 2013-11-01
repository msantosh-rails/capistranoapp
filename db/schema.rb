# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130503123700) do

  create_table "attachments", :force => true do |t|
    t.string   "attachment_name"
    t.binary   "attach"
    t.integer  "task_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "attachments", ["task_id"], :name => "index_attachments_on_task_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "org_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "organizations", ["org_name"], :name => "org_name", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "pname"
    t.integer  "ptypeid"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "projects", ["organization_id"], :name => "index_projects_on_organization_id"

  create_table "projecttypes", :force => true do |t|
    t.integer  "ptypeid"
    t.string   "ptype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "tname"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"

end
