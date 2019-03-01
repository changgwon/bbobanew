class EditUserStdnum < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :stdnum, :integer, null: false
  end
end
