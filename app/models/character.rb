class Character < ApplicationRecord
  belongs_to :actor, optional: true
end
