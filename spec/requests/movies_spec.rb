# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get movies_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get movies_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get movie_path(movie)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get movie_path(movie)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #add_to_watchlist' do
    it 'adds a movie to user\'s watchlist' do
      expect do
        post movie_add_to_watchlist_path(movie)
      end.to change(user.watchlist, :count).by(1)
    end

    it 'redirects to the movie' do
      post movie_add_to_watchlist_path(movie)
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe 'DELETE #remove_from_watchlist' do
    before do
      user.watchlist << movie
    end

    it 'removes a movie from user\'s watchlist' do
      expect do
        delete movie_remove_from_watchlist_path(movie)
      end.to change(user.watchlist, :count).by(-1)
    end

    it 'redirects to the movie' do
      delete movie_remove_from_watchlist_path(movie)
      expect(response).to redirect_to(movie_path(movie))
    end
  end
end
