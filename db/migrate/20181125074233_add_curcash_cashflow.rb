class AddCurcashCashflow < ActiveRecord::Migration[5.2]
  def change
  	add_column :cashflows, :cur_cash, :integer
  end
end
