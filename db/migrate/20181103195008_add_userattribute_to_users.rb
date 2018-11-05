class AddUserattributeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :usertype, :string
    add_column :users, :phonenum, :string
    add_column :users, :username, :string
    add_column :users, :stdnum, :integer
    add_column :users, :cur_cash, :integer
    add_column :users, :expt_cash, :integer
  end
end
