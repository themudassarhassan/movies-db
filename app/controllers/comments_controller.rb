# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[create destroy]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @movie.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @movie }
      end
    else
      head :no_content
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @movie }
      end
    else
      head :forbidden
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
