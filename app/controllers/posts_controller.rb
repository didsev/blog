class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show 
    @users_ids = PostsUser.where(post_id: params[:id]).pluck(:id)
    @users = User.where(id: @users_ids)
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def new
    @post = Post.new
    flash[:error] = nil
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      params[:users].each do |user_id|
        PostsUser.create(user: User.find(user_id), post: @post)
      end

        flash[:error] = nil
        redirect_to root_path
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