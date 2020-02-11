Rails.application.routes.draw do
  get 'users/sign_up' => 'products#index'
  devise_for :users
  resources :users, only:[:index, :new, :create, :edit, :update, :destroy]
  get 'users/:id/edit_password' => 'users#edit_password', as: :edit_password_user
  root 'products#index'
  get 'products/myproducts' => 'products#myproducts'
  get 'categories/mycategories' => 'categories#mycategories'
  resources :products, only:[:index, :new, :create, :edit, :update, :destroy, :show]
  resources :categories, only:[:index, :new, :create, :edit, :update, :show]
end
