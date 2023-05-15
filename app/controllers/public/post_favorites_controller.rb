class Public::PostFavoritesController < ApplicationController
 before_action :ensure_guest_user
  def create
    @post_favorite = PostFavorite.new(user_id: current_user.id,post_id: params[:post_id])
    @post_favorite.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @post_favorite = PostFavorite.find_by(user_id: current_user.id,post_id: params[:post_id])
    @post_favorite.destroy
    redirect_to post_path(params[:post_id])
  end
private
  def post_favorite_params
    params.require(:post_favorite).permit(:post_id)
  end


  def ensure_guest_user
    @post = Post.find(params[:post_id])
    if current_user.name == "guestuser"
      redirect_to post_path(@post.id) , notice: 'ゲストユーザーはコメントができません。'
    end
  end
end
