class AddPgnumToUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :pagenum, :integer
  end
end
