class AddUploadattributeToUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :totalpage, :string
  end
end
