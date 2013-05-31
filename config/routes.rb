KidsCash::Application.routes.draw do
  root :to => "kids#index"
  resources :kids
  match "kids/add-transaction" => "kids#add_transaction"
  match "kids/add-kid" => "kids#add_kid"
end
