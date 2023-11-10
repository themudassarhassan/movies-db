# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :watched_movies, dependent: :destroy
  has_many :comments, dependent: :destroy
end
