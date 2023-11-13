# frozen_string_literal: true

class WatchlistController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:destroy]

  def index
    @movies_to_watch = current_user.watchlist
  end

  def destroy
    current_user.watchlist.destroy(@movie)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to watchlist_index_path }
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
