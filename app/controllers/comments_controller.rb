class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner, :upvote, :downvote]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    @comment.parent_id = params[:parent_id]
      respond_to do |format|
        format.js { render 'new', status: :created, location: @post }
        format.html { redirect_to @post }
      end
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js { render 'create', status: :created, location: @post }
        format.html { redirect_to @post }
        flash[:notice] = t('.notice')
      else
        render 'new'
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post
      flash[:notice] = t('.notice')
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to @post }
    end

  end

  def upvote
    @comment.upvote_from current_user
    respond_to do |format|
      format.js { render 'vote', status: :created, location: @post }
    end
  end

  def downvote
    @comment.downvote_from current_user
    respond_to do |format|
      format.js { render 'vote', status: :created, location: @post }
    end
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = 'You have no permission'
      redirect_to @post
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :parent_id)
  end
end