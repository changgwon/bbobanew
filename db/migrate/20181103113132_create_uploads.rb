class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
    	t.string :userid
    	t.integer :stdnum
    	t.string :attachment

    	t.string :printer
    	t.string :pkuptime
    	t.string :progress

    	t.boolean :landscape
    	t.boolean :doublepg
    	t.integer :split
    	t.boolean :color
      	t.timestamps
    end
  end
end
