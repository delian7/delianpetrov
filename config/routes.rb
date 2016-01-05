Rails.application.routes.draw do
  root to: 'visitors#index'
  get "small_url", to: "links#create_small_url"
  match "*path", to: "links#go_to_url", via: :all
end
