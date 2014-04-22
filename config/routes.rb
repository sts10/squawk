Rails.application.routes.draw do
  get '/' => 'timelines#index'
  get '/auth/twitter/callback' => 'timelines#show' 
end
