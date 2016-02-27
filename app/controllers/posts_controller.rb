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
  if @post.update(post_params)
    PostsUser.where(post_id: @post.id).destroy_all
  
    params[:users].each do |user_id|
      PostsUser.create(user: User.find(user_id.to_i), post: @post)
    end if params[:users].present?

    flash[:error] = nil
    redirect_to post_path(@post)
  else
    flash[:error] = 'Error while saving'
    render action: 'edit', object: @post
  end
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