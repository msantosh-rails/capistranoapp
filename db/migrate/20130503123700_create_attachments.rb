class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachment_name
      t.binary :attach
      t.references :task

      t.timestamps
    end
    add_index :attachments, :task_id
  end
end
