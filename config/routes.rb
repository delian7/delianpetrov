Rails.application.routes.draw do
  root to: 'visitors#index'
  match "*path", to: "visitors#go_to_url", via: :all
end
