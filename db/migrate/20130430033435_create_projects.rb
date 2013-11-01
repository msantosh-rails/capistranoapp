class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :pname
      t.integer :ptypeid
      t.references :organization

      t.timestamps
    end
    add_index :projects, :organization_id
  end
end
