# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :release_date, :poster_path, :overview, presence: true

  has_many :comments, dependent: :destroy
end
