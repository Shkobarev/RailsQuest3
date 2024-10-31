Rails.application.routes.draw do
   root "home#index"
   get '/add_unit/:id' => 'home#add_unit'
   get '/ultimate/:id' => 'home#ultimate'
end
