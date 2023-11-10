# frozen_string_literal: true

class WatchedMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
