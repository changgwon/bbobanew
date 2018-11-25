class ChangeColumnCashflow < ActiveRecord::Migration[5.2]
  def change
  	change_column :cashflows, :amount, :integer
  end
end
