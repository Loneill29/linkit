Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end
   
  resources :questions

  get 'questions/show'

  get 'questions/edit'

  resources :advertisements

  get 'advertisements/show'

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
