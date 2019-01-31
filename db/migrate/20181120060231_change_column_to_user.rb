class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :cur_cash, :integer, :default => 0
  	change_column :users, :expt_cash,:integer, :default => 0
	change_column :users, :usertype, :string,:default => "user"
  end
end
