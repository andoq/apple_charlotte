class CommentsController < ApplicationController

  def create
    unless verify_recaptcha
      redirect_to :back, :notice => "Image validation was incorrect.  Please try again." and return
    end
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to :back, :notice => "Thanks for adding a comment"
    else
      redirect_to :back, :notice => 'Comment was not saved'
    end
  end

  def index
    @comments = Comment.order('id DESC').limit(1000)
  end

  def form
    @new_comment = Comment.new(:commentable_type => params[:commentable_type], :commentable_id => params[:commentable_id])
    render :layout => false
  end

end
