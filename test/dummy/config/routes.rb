Rails.application.routes.draw do

  resources :assets
  resource :asset do 
    get 'tax_year/:tax_year'=>'assets#tax_year', :as=>"tax_year"
  end


  mount RedPanda::Engine => "/red_panda"
end
