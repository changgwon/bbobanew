Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'home#index'
  get 'home/new2'
  get 'home/main'
  get 'home/fileupload'
  post 'home/filecreate'
  get 'home/filecurrent'
  get 'home/ownerpage'
  get 'home/changeState/:id'=>'home#changeState'

  get 'home/index' => 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
