# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { { body: 'This is a valid comment' } }

      it 'creates a new comment for the movie' do
        expect do
          post movie_comments_path(movie), params: { comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the movie' do
        post movie_comments_path(movie), params: { comment: valid_attributes }
        expect(response).to redirect_to(movie)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { body: '' } } # assuming body cannot be blank

      it 'does not create a new comment' do
        expect do
          post movie_comments_path(movie), params: { comment: invalid_attributes }
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, user:, movie:) }

    it 'deletes the comment' do
      expect do
        delete movie_comment_path(movie, comment)
      end.to change(Comment, :count).by(-1)
    end

    it 'redirects to the movie' do
      delete movie_comment_path(movie, comment)
      expect(response).to redirect_to(movie)
    end

    context 'when the comment is not owned by the current_user' do
      let(:another_user) { create(:user) }

      before do
        sign_out user
        sign_in another_user
      end

      it 'does not delete the comment' do
        expect do
          delete movie_comment_path(movie, comment)
        end.not_to change(Comment, :count)
      end
    end
  end
end
