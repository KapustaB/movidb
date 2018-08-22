desc "This task is for importing movie/@@crew_member data from Moviedb API"

task :get_100_popular_movies => :environment do
  puts "Geting movies data..."

  ImportPopularMoviesJob.perform_now(6)
end

task :get_movie_genres => :environment do
  puts "Geting movie genres..."

  ImportMovieGenresJob.perform_later
end