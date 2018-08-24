# Web app for static retroreflection testing 



## Installation:

## Install Ruby & Rails
ruby -v ruby 2.5.1
rails -v Rails 5.1.6

Follow these easy steps to install and start the app:

### Set up Rails app

First, install the gems required by the application:

	bundle install 

Setup database in config/database.yml

	
Next, execute the database migrations/schema setup:

	```bundle exec rake db:setup```
or
  
	```bundle exec rake db:schema:load```
	

### Start the app

You're ready to localize your app:

   ```bundle exec rails server```
	

### Import data from movidb API 

1. Import all genres
  
	```rake get_movie_genres```
  
2. Import 100 popular movies and crew_members/actors  
```
	rake get_100_popular_movies
```

### ENV file
```
	BUGSNAG_API_KEY
	S3_KEY
	S3_SECRET
	S3_REGION
	S3_BUCKET_NAME
  MOVIEDB_API_KEY
```



	
