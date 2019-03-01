class AddConfirmableToDevise2 < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :userid, :string, null: false, unique: true
  	change_column :users, :username, :string, null: false
  	change_column :users, :stdnum, :integer, null: false, unique: true
  	change_column :users, :phonenum, :integer, null: false
  end
end
