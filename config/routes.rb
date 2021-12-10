Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope 'user' do
    get 'login', to: 'user#login'
    get 'show', to: 'user#show'
    get 'logout', to: 'user#logout'
    post 'create', to: 'user#create'
    patch 'update/:id', to: 'user#update'
    delete 'delete/:id', to: 'user#delete'
  end
  scope 'admin' do
    get 'login', to: 'admin#login'
    get 'logout', to: 'admin#logout'
  end
  get 'authentication_failure', to: 'application#authentication_failure', as: :authentication_failure
  patch 'authentication_failure', to: 'application#authentication_failure'
  delete 'authentication_failure', to: 'application#authentication_failure'


  namespace 'api' do
    namespace 'v1' do
      scope 'types' do
        get '/', to: 'type#index'
        get 'show/:id', to: 'type#show'
        post 'create', to: 'type#create'
        patch 'update/:id', to: 'type#update'
        delete 'delete/:id', to: 'type#delete'
      end
      scope 'products' do
        get '/', to: 'product#index'
        get 'show/:id', to: 'product#show'
        post 'create', to: 'product#create'
        patch 'update/:id', to: 'product#update'
        delete 'delete/:id', to: 'product#delete'
      end
      scope 'favourites' do
        get '/', to: 'favourite#index'
        get ':id', to: 'favourite#is_favourite'
        post 'create', to: 'favourite#create'
        patch 'update/:id', to: 'favourite#update'
        delete 'delete/:id', to: 'favourite#delete'
      end
    end
  end
end
