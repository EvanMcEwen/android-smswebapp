class CreateSynchashes < ActiveRecord::Migration
  def change
    create_table :synchashes do |t|
      t.string :in_hash
      t.string :out_hash
      t.references :user

      t.timestamps
    end
    add_index :synchashes, :user_id
  end
end
