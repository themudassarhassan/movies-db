# frozen_string_literal: true

class MoviesService
  attr_reader :query, :movie_id

  def initialize(params)
    @query = params[:query]
    @movie_id = params[:id]
  end

  def index
    if query.present?
      Tmdb::Search.movie(query)
    else
      Tmdb::Movie.top_rated
    end
  end

  def show
    movie = Movie.includes(:comments).where(id: movie_id).first
    return movie if movie.present?

    movie_from_api = Tmdb::Movie.detail(movie_id)
    Movie.create(id: movie_from_api.id, title: movie_from_api.title,
                 release_date: movie_from_api.release_date,
                 overview: movie_from_api.overview,
                 poster_path: movie_from_api.poster_path)
  end
end
