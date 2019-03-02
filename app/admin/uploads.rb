ActiveAdmin.register Upload do
  permit_params :userid, :stdnum, :attachment ,:printer, :progress, :totalpage, :split, :cost, :user_id, :color, :pkupdate, :pkuptime
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
######################정보는 https://activeadmin.info/###################
index do
  selectable_column
  id_column


  column :userid
  column :stdnum
  column :printer
  column :progress
  column :totalpage
  column :split
  column :cost
  column :color
  column :user_id
  column :pkupdate
  column :pkuptime
 
  actions
end

index as: :grid do |product|
  link_to image_tag(product.image_path), admin_product_path(product)
end


end
