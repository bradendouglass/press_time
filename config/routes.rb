TimePress::Application.routes.draw do

  root :to => "run_stamps#new"
  resources :run_stamps
end
