Rails.application.routes.draw do
  root to: 'visitors#index'
  get "small_url", to: "links#create_small_url"
  post "send_email", to: "visitors#send_email"
  match "*path", to: "links#go_to_url", via: :all
end
