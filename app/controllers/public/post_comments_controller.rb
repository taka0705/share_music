class Public::PostCommentsController < ApplicationController
 before_action :ensure_guest_user
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    PostComment.find_by(id: params[:id],post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_guest_user
    @post = Post.find(params[:post_id])
    if current_user.name == "guestuser"
      redirect_to post_path(@post.id) , notice: 'ゲストユーザーはコメントができません。'
    end
  end


end
