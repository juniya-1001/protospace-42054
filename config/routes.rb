Rails.application.routes.draw do
  devise_for :users #devise関連のルーティンングをすべて設定している。
  root to: "prototypes#index"
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show

end

#ネストによって，親のID情報を含めることができる。
#ネストの必要がない場合は，do end は必要ない。