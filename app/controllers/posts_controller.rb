class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = Post.all.includes(:photos, :user, :likes).order("created_at desc")
  end

  def show
    @post = Post.find(params[:id])
    @photos = @post.photos
    @is_liked = @post.is_liked(current_user)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: img)
        end
      end

      redirect_to posts_path
      flash[:notice] = "Post successfully saved"
    else
      flash[:alert] = "Couldn't save post"
      redirect_to posts_path
    end
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = "Post successfully deleted."
      else
        flash[:alert] = "Couldn't delete post."
      end
    else
      flash[:alert] = "You don't have the permission to delete this post!"
    end
    redirect_to root_path
  end

  private
  def find_post
    @post = Post.find_by(id: params[:id])

    return if @post
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
