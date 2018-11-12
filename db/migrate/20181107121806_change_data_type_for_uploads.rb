class ChangeDataTypeForUploads < ActiveRecord::Migration[5.2]
  def change
  	change_column :uploads, :color, :string
  	change_column :uploads, :landscape, :string
  	change_column :uploads, :doublepg, :string
  end
end
