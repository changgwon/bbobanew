class ChangePkupdateTypeInUploads < ActiveRecord::Migration[5.2]
  def change
  	change_column :uploads, :pkupdate, :date
  end
end
