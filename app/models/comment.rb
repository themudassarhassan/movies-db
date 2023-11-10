class Comment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :movie
  belongs_to :user
end
