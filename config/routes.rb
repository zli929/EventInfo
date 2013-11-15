EventInfo::Application.routes.draw do
  devise_for  :users, 
              :controllers => { :registrations => "users/registrations",
                                :sessions => "users/sessions",
                                :omniauth_callbacks => "users/omniauth_callbacks",
                                :confirmations => "users/confirmations" }
  devise_scope :user do
    match '/signin',  to: 'devise/sessions#new', via: [:get, :post]
    match '/signout', to: 'devise/sessions#destroy', via: :delete
  end
 
  root to: 'static_pages#home'
  
  get 'tags/:tag', to: 'static_pages#home', as: :tag
 
  # Setting up Android Access
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end
  
  resources :cab_departures do
    get 'join' => 'cab_departures#join'
    get 'unjoin' => 'cab_departures#unjoin'
  end
  
  resources :advertisements do
    collection do
      get :autocomplete_tag_name
    end
  end
  resources :users do
    get 'single_signon_email_req', on: :new
  end
  
  resources :advertisement_comments, only:    [:create, :destroy]

  #match '/signup',  to: 'users#new'
  match '/after_signup', to: 'static_pages#after_signup', via: [:get]
  match '/help',    to: 'static_pages#help', via: [:get]
  match '/about',   to: 'static_pages#about', via: [:get]
  match '/contact', to: 'static_pages#contact', via: [:get]
  match '/disclaimer', to: 'static_pages#disclaimer', via: [:get]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
