class AddNicknameToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :nickname, :string
  end
end
