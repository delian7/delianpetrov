Rails.application.routes.draw do
  root to: 'visitors#index'
  get "small_url", to: "links#create"
  get "small_url/list", to: "links#list_nicknames"
  post "send_email", to: "visitors#send_email"
  match "*path", to: "links#go_to_url", via: :all
end

