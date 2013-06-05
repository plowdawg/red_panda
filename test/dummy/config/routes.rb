Rails.application.routes.draw do

  resources :assets


  mount RedPanda::Engine => "/red_panda"
end
