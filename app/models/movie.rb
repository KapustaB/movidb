class Movie < ApplicationRecord
  validates :title, presence: true

  has_many :movie_crew_members
  has_many :crew_members, through: :movie_crew_members

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  has_many :images

  has_many :characters
end
