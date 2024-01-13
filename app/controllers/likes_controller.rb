class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post

    if @like.save
      respond_to :js
    else
      flash[:alert] = "Couldn't save like"
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post

    if @like.destroy
      respond_to :js
    else
      flash[:alert] = "Couldn't delete like"
    end
  end

  private
  def like_params
    params.permit :post_id
  end
end
