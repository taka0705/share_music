class User < ApplicationRecord
  has_one_attached :user_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :post_favorites,dependent: :destroy
  has_many :post_comments,dependent: :destroy
  
  has_many :posts
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
