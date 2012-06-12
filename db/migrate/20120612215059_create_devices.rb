class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :reg_id
      t.references :user

      t.timestamps
    end
    add_index :devices, :user_id
  end
end
