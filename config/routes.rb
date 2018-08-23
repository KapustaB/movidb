Rails.application.routes.draw do
  resources :actors
  resources :images
  resources :genres
  resources :crew_members
  resources :movies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#index'
  get 'search_movies' => 'movies#search'
  get 'show_actor' => 'actors#show'
  get 'show_movies_by_genre' => 'movies#sort_by_genre'
  get 'like_movie' => 'movies#like'
  get 'unlike_movie' => 'movie#unlike'
end
