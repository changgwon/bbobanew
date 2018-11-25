ActiveAdmin.register Charge do
  permit_params :user, :amount, :deposit 

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

  column :amount
  column :deposit
  column :created_at
  column :user
  column :user_id
  actions
end

index as: :grid do |product|
  link_to image_tag(product.image_path), admin_product_path(product)
end

batch_action :확인완료 do |ids|
    batch_action_collection.find(ids).each do |charge|
      	charge.deposit = true
      	charge.save
        user=User.find(charge.user_id)
        user.cur_cash=user.cur_cash + charge.amount
        user.save
        cashflow=Cashflow.new
        cashflow.user_id=charge.user_id
        cashflow.real_created_at = charge.created_at
        cashflow.amount = charge.amount
        cashflow.use_type = "충전"
        cashflow.cur_cash=user.cur_cash
        cashflow.save

      	 
    end
    redirect_to collection_path
    #redirect_to collection_path, alert: "The posts have been flagged."
  end

  batch_action :철회 do |ids|
    batch_action_collection.find(ids).each do |charge|
      if charge.deposit == true
        charge.deposit = false
        charge.save
        a=User.find(charge.user_id)
        
        a.cur_cash=a.cur_cash - charge.amount
        a.save
      end   
    end
    redirect_to collection_path
    #redirect_to collection_path, alert: "The posts have been flagged."
  end
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
