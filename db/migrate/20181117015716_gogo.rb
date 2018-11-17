class Gogo < ActiveRecord::Migration[5.2]
  def change
   remove_column :charges, :user_num    
  end
end
