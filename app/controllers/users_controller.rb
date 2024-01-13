class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.all.where(:user_id => @user.id).includes(:photos);
  end
end
