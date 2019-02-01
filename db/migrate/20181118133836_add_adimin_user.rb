class AddAdiminUser < ActiveRecord::Migration[5.2]
  def change
  	    add_column :admin_users, :userid, :string, unique: true

  end
end
