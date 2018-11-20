class ChangeStringToIntInUpload < ActiveRecord::Migration[5.2]
  def change
  	change_column :uploads, :pagenum, :string
  	change_column :uploads, :totalpage, :integer
  	change_column :uploads, :landscape, :string
  	change_column :uploads, :doublepg, :string
  	change_column :uploads, :split, :string
  	change_column :uploads, :color, :string
  end
end
