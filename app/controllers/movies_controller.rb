# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :authenticate_user!
  # GET /movies
  def index
    @response = if params[:query].present?
                  Tmdb::Search.movie(params[:query])
                else
                  Tmdb::Movie.top_rated
                end
  end

  def show
    @movie = Movie.includes(:comments).where(id: params[:id]).first
    return if @movie.present?

    movie_from_api = Tmdb::Movie.detail(params[:id])
    @movie = Movie.create(id: movie_from_api.id, title: movie_from_api.title,
                          release_date: movie_from_api.release_date, overview: movie_from_api.overview, poster_path: movie_from_api.poster_path)
  end

  private

  def movie_params
    params.permit(:query)
  end
end
