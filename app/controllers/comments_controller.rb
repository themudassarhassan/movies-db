# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:create]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @movie.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @movie }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @comment.user == current_user

    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @movie }
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
