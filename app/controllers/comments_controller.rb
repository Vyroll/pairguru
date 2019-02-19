class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def index
    @comments = current_user.comments
  end
  
  def create
    @movie = Movie.find(comment_params[:movie_id])
    @comment = current_user.comments.create(comment_params.merge(created_at: Time.now))
    @comment.errors.full_messages.each do |message|
      flash[:error] = message
    end
    
    redirect_to movie_path(@movie)
  end
  
  def showcase
    @users = User.joins(:comments).group("comments.user_id").order("count(comments.user_id) desc").limit(10)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
    else
      flash[:error] = "You don't own this comment and you can't delete it."
    end
    redirect_to comments_path
  end
  
  private
  def comment_params
    params.require(:comment).permit(:text, :movie_id)
  end
end
