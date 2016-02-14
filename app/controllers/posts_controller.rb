class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def new
    @post = Post.new
    flash[:error] = nil
    @users = User.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:users]

  if @post.save
      redirect_to root_path
      flash[:error] = nil
    else
      flash[:error] = 'Error while saving'
      render action: 'new', object: @post
   end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

end