TimeInternationalECommerce::Application.routes.draw do
  get "business/index"
  get "business/query_shipping_list"
  get "business/shipping_list"
  get "business/export_to_csv"
  get "business/order_search_form"
  get "business/orders_search_result_list" => "business#get_orders_searching_result"

  resources :bonus_upgrade_details

  resources :shipping_fees

  resources :discount_details

  resources :orders

  resources :line_items

  resources :carts

  resources :categories

  resources :products

  resources :profiles

  resources :roles

 
  devise_for :users

  resources :users
  get "main/index" => "main#index", :as=>'management'
  get "main/statistic_turnover_form"
  get "main/statistic_turnover_search"
  get "main/statistic_goods_sales_form"
  get "main/statistic_goods_sales_search"
  get "main/statistic_balance_form"
  get "main/statistic_balance_search"

  get "users_search_list" => "users#new_users_search", :as=>'users_searching'
  get "users_search_result_list" => "users#users_search" 
  match 'productslist/:category_id' => "Products#show_products_by_category"
  match 'order_search_form' => "Orders#order_search_form"
  match 'orderconfirmation/:id' => "Orders#order_confirmation"
 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "products#index", :as => "root"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
