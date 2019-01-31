class AddCategoryToUpload < ActiveRecord::Migration[5.2]
  def change
  	add_column :uploads, :category, :string, default: "ongoing"
  end
end
