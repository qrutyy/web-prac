Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    get "auth/start"
    get "auth/verify"
    root "articles#index"
    get "/articles", to: "articles#index"
    post '/auth/vk/success', to: 'auth#vk_success'
    get '/auth/telegram/callback', to: 'auth#telegram'
    get '/auth/github', to: 'auth#github'
    get '/auth/github/callback', to: 'auth#github'
    get '/auth/github/failure', to: 'auth#github_failure'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

  end
  
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
