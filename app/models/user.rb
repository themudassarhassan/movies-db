# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_and_belongs_to_many :watchlist, class_name: 'Movie', dependent: :destroy
  has_many :comments, dependent: :destroy
end
