RecruitMe::Application.routes.draw do

  resources :users, only: [] do
    get 'friends_with/:id' => 'users#friends_with', on: :collection
    get 'skilled_at/:skill' => 'users#skilled_at', on: :collection
    get 'unskilled_at/:skill' => 'users#unskilled_at', on: :collection
    get 'living_in/:city' => 'users#living_in', on: :collection
    get 'not_from/:country' => 'users#not_from', on: :collection
  end

  resources :positions, only: [] do
    get 'popular_skills' => 'positions#popular_skills', on: :collection
  end

  resource :search, only: [] do
    get 'popular' => 'search#popular', on: :collection
    get ':index' => 'search#search', on: :collection
    get ':index/autocomplete' => 'search#autocomplete', on: :collection
  end

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
