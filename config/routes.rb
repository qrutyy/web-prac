Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    get "auth/start"
    get "auth/verify"
    root "articles#index"
    get "/articles", to: "articles#index"
    post '/auth/vk/success', to: 'auth#vk_success'
    get '/auth/telegram/callback', to: 'auth#telegram'
  end

  # OmniAuth routes
  match '/auth/:provider/callback', to: 'auth#github', via: [:get, :post]
  match '/auth/failure', to: 'auth#github_failure', via: [:get, :post]

  get "up" => "rails/health#show", as: :rails_health_check
end

