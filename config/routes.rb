Rails.application.routes.draw do

  resources :payrolls

  resources :pay_dates, only: [:index, :create, :destroy]

  root to: redirect('/payrolls')
end
