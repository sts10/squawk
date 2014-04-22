Rails.application.routes.draw do

  get '/' => 'tweets#index'

  get '/auth/twitter/callback' => 'timelines#show' 

  get '/test' => 'timelines#test'

end
