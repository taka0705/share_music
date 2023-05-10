class Public::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_guest_user, only: [:edit]
  def show
  end

  def edit
  end

  def update
  end

  def mypage
  end

  def check
  end

  def withdraw
  end

  def favorites
  end

  def complete
  end

private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  

end