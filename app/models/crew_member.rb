class CrewMember < ApplicationRecord
  has_many :movie_crew_members
  has_many :movies, through: :movie_crew_members
end
