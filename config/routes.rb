Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'tiny_url', to: 'links#create'
  get 'list', to: 'links#list'
  post 'send_email', to: 'visitors#send_email'
  get ':path' => 'links#go_to_url', :as => :page, :constraints => ->(req) { req.path !~ /\.(png|jpg|js|css)$/ }
end
