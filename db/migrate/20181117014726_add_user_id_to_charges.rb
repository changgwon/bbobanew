class AddUserIdToCharges < ActiveRecord::Migration[5.2]
  def self.up
    add_column :charges, :user_id, :integer
  end

  def self.down
    remove_column :charges, :user_num
  end
end
