class AddPkupdatecolToUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :pkupdate, :string
  end
end
