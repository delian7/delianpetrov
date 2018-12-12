Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'short_url', to: "links#create"
  get "list", to: "links#list"
  post "send_email", to: "visitors#send_email"
  match "*path", to: "links#go_to_url", via: :all
end

