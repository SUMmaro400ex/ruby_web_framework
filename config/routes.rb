module Routes
  class Routes < Kwypper::Routes
    resources :welcome

    get '/login' => 'welcome#new'

    root 'welcome#index'

  end
end