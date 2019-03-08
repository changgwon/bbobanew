Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
  }
  root 'home#index'
  get 'home/after_registration'
  get 'home/refund'
  get 'home/manual'
  get 'home/main'
  get 'home/fileupload'
  post 'home/filecreate'
  post 'home/filecheck'
  get 'home/filecurrent'
  get 'home/ownerpage'
  get 'home/ownerpage_tomo'
  get 'home/changeState1/:id'=>'home#changeState1'
  get 'home/changeState2/:id'=>'home#changeState2'
  get 'home/changeState3/:id'=>'home#changeState3'
  get 'home/changeState4/:id'=>'home#changeState4'
  get 'payment/new' => 'payment#new'
  get 'home/filedetail/:id' => 'home#filedetail'
  get 'home/index' => 'home#index'
  get 'printer/index' => 'printer#index'
  get 'printer/account' => 'printer#account'
  get 'printer/detail' => 'printer#detail'
  get 'home/category1' => 'home#category1'
  get 'home/category2' => 'home#category2'
  get 'home/category3' => 'home#category3'
  get 'home/usercancel/:id' => 'home#usercancel'
  get 'home/category' => 'home#category'

  get 'payment/charge' => 'payment#charge'
  post 'payment/create'
  get 'payment/new'
  get 'payment/charge_show'
  delete 'payment/charge_delete/:charge_id' => 'payment#charge_delete'
  get 'payment/cashflow'
end