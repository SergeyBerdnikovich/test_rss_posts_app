Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :cp do
    resources :feed_urls
    resources :posts

    root to: "feed_urls#index"
  end

  root to: "cp/feed_urls#index"
end
