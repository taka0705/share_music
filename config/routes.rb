Rails.application.routes.draw do

# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin,skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}


  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:index, :show]
    resources :genres, only: [:index, :create, :update, :edit]
    resources :users, only: [:show, :edit, :update]

    get '/searches' => 'searches#search'

  end


  scope module: :public do
    root to: "homes#top"

    get '/about' => 'homes#about',as: 'about'
    resources :posts, only: [:index, :show, :edit, :update, :new, :create] do
      resources :post_favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
    get 'users/my_page' => 'users#mypage'
    get 'users/check' => 'users#check'
    patch 'users/withdraw' => 'users#withdraw'
    get 'users/favorites' => 'users#favorites'
    get 'users/complete' => 'users#complete'



    get '/searches' => 'searches#search'


  end

end
