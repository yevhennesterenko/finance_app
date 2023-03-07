Rails.application.routes.draw do
  get 'reports/index'
  get 'reports/report_by_dates'
  get 'reports/report_by_category'
  root 'main#index'
  get 'main/index'
  resources :categories do
    resources :operations
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
