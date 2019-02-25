class EditUserColumn1 < ActiveRecord::Migration[5.2]
  def change
  	  	change_column :users, :phonenum, :integer, null: false

  end
end
