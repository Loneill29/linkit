Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show]

  post 'users/confirm' => "users#confirm"

  resources :questions do
    resources :answers, only: [:create, :destroy]
  end

  resources :advertisements

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
