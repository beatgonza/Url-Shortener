UrlShortener::Application.routes.draw do

  resources :urls, :only => [:show, :new, :create]

  root :to => redirect('/urls/new')

  # Routes for JS API
  match '/urls_api' => 'urls#create_api', :via => :post
  match '/urls_api/:id' => 'urls#show_api', :via => :get, :as => :urls_api
 

end
