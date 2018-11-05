Rails.application.routes.draw do
  root 'home#main'
  get 'home/new2'
  get 'home/main'
  get 'home/fileupload'
  post 'home/filecreate'
  post 'home/filecheck'
  get 'home/filecurrent'
  get 'home/ownerpage'
  get 'home/changeState/:id'=>'home#changeState'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
