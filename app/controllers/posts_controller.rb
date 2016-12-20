class PostsController < ApplicationController

  before_action :require_user, only: [:index, :show, :edit, :update]

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  before_action :update_views


  def index
    @posts = Post.all.includes(:comments)
    @comments = Comment.all
  end


  def show
    @comments = Comment.where(post_id: @post).order('created_at DESC')

  end

  def new
    @post = Post.new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: t('.notice') }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice:  t('.notice') }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def update_views
    if cookies[:views].present?
      cookies[:views] = cookies[:views].to_i + 1
    else
      cookies[:views] = 1
    end
    if cookies[:views] % 10 == 0
      flash.now[:notice] = t('Study ROR with GeekHub!!!')
    end
  end
end