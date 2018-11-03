Rails.application.routes.draw do
  root 'home#new2'
  get 'home/new2'
  get 'home/main'
  get 'home/fileupload'
  get 'home/filecreate'
  get 'home/filehistory'
  get 'home/filecurrent'
  get 'home/ownerpage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
