Rails.application.routes.draw do
  root "card_draw#index"

  get "card_draw/index"
  post "card_draw/draw", to: "card_draw#draw"
  get "quest_cards/download", to: "quest_cards#download"

  resources :quest_cards do
    collection do
      get :edit_multiple
      patch :update_multiple
    end
  end

  get "pages/index"
  get "up" => "rails/health#show", as: :rails_health_check
end
