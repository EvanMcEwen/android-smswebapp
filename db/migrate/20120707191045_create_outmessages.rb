class CreateOutmessages < ActiveRecord::Migration
  def change
    create_table :outmessages do |t|
      t.string :destination
      t.string :message
      t.string :timestamp
      t.references :user

      t.timestamps
    end
    add_index :outmessages, :user_id
  end
end
