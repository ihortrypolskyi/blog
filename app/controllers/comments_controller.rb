class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :upvote, :downvote]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def create
    @comment = @post.comments.create(params[:comment].permit(:content))
    @comment.user = current_user
    #@comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def upvote
    @comment.upvote_from current_user
    redirect_to post_path(@post)
  end

  def downvote
    @comment.downvote_from current_user
    redirect_to post_path(@post)
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user == @comment.user
      flash[:notice] = 'You have no permission'
      redirect_to @post
    end
  end
end