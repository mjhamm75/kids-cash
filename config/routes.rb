KidsCash::Application.routes.draw do
  resources :kids
  match "kids/add-transaction" => "kids#add_transaction"
end
