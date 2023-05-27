class Public::HomesController < ApplicationController

  def top
    @posts = Post.all.includes(:user).where(users: {user_status: "有効"}).order(created_at: :desc)
  end

  def about
  end

end
