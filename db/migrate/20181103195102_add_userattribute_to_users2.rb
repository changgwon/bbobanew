class AddUserattributeToUsers2 < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :userid, :string, unique: true
  end
end
