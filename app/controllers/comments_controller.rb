class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to :back, :notice => "Thanks for adding a comment"
    else
      redirect_to :back, :notice => 'Comment was not saved'
    end
  end

  def index
    @comments = Comment.limit(1000)
  end

end
