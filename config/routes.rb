Rails.application.routes.draw do
  get "card_draw/index"
  get "pages/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  #root 'pages#index'
  root 'card_draw#index'
  post 'quest_cards', to:'quest_cards#create'#csvのアップロード処理
  get "card_draw/index"
  post "card_draw/draw", to:"card_draw#draw"
  get 'quest_cards/download',to: 'quest_cards#download'#csvダウンロード
end
