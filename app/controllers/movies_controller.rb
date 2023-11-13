# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[add_to_watchlist remove_from_watchlist]

  def index
    @response = MoviesService.new(params).index
  end

  def show
    @movie = MoviesService.new(params).show
  end

  def add_to_watchlist
    current_user.watchlist << @movie

    redirect_to movie_path(@movie)
  end

  def remove_from_watchlist
    current_user.watchlist.destroy(@movie)

    redirect_to movie_path(@movie)
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def movie_params
    params.permit(:query)
  end
end
