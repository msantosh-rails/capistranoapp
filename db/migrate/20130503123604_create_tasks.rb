class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :tname
      t.references :project

      t.timestamps
    end
    add_index :tasks, :project_id
  end
end