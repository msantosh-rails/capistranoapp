class CreateProjecttypes < ActiveRecord::Migration
  def change
    create_table :projecttypes do |t|
      t.integer :ptypeid
      t.string :ptype

      t.timestamps
    end
  end
end
