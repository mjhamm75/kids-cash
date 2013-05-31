KidsCash::Application.routes.draw do
  resources :kids
  match "kids/add-transaction" => "kids#add_transaction"
  match "kids/add-kid" => "kids#add_kid"
end
