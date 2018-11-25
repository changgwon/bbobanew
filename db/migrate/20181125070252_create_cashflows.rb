class CreateCashflows < ActiveRecord::Migration[5.2]
  def change
    create_table :cashflows do |t|
    	t.integer :user_id
    	t.datetime :real_created_at
    	t.string :use_type
    	t.string :amount
      t.timestamps
    end
  end
end
