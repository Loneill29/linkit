Rails.application.routes.draw do

  resources :questions
  
  get 'questions/show'

  get 'questions/edit'

  resources :advertisements

  get 'advertisements/show'

  resources :posts

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
