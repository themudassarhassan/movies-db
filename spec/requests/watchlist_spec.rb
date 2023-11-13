# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WatchlistController do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get watchlist_index_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get watchlist_index_path
      expect(response).to render_template(:index)
    end

    it 'assigns @movies_to_watch' do
      get watchlist_index_path
      expect(assigns(:movies_to_watch)).to eq(user.watchlist)
    end
  end

  describe 'DELETE #destroy' do
    context 'when the movie is in the user watchlist' do
      before do
        user.watchlist << movie
      end

      it 'deletes the movie from watchlist' do
        expect do
          delete watchlist_path(movie)
        end.to change(user.watchlist, :count).by(-1)
      end

      it 'redirects to the index page' do
        delete watchlist_path(movie)
        expect(response).to redirect_to(watchlist_index_path)
      end
    end

    context 'when the movie is not in the user watchlist' do
      it 'does not remove any movie from the watchlist' do
        expect do
          delete watchlist_path(movie)
        end.not_to change(user.watchlist, :count)
      end
    end
  end
end
