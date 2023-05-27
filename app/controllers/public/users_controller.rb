class Public::UsersController < ApplicationController
    before_action :authenticate_user!,only: [:show,:edit,:update,:my_page,:check,:withdraw,:favorites]
    before_action :ensure_guest_user, only: [:edit,:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "更新に成功しました。"
        redirect_to user_my_page_path
      else
        flash.now[:alert] = "更新に失敗しました。以下のエラーを修正してください。"
        render :edit
      end
  end

  def my_page
    @user = current_user
    @posts = @user.posts.all.order(created_at: :desc)
  end

  def check
    @user = current_user
  end

  def withdraw
    user = current_user
    user.update(user_status: 1)
    reset_session
    redirect_to user_complete_path
  end

  def favorites
    @user = current_user
    favorites = PostFavorite.where(user_id: @user.id).order(created_at: :desc).pluck(:post_id)
    @favorites_posts = Post.includes(:user).where(users: {user_status: "有効"}).where(id: favorites).page(params[:page]).per(10)
  end

  def complete
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :user_image, :email)
  end

  def ensure_guest_user
    @user = current_user
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
