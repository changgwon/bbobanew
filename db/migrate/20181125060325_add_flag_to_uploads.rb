class AddFlagToUploads < ActiveRecord::Migration[5.2]
  def change
  	add_column :uploads, :flag, :boolean, default: true
  	add_column :uploads, :cost, :integer
  end
end
