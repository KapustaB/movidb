class Image < ApplicationRecord
  belongs_to :movie, optional: true
  mount_uploader :poster, PosterUploader
end
