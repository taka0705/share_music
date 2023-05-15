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

 devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end



  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:index, :show] do
         resources :post_comments, only: [:destroy]
    end
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
    get 'user/my_page' => 'users#my_page'
    get 'user/check' => 'users#check'
    patch 'user/withdraw' => 'users#withdraw'
    get 'user/favorites' => 'users#favorites'
    get 'user/complete' => 'users#complete'



    get '/searches' => 'searches#search'


  end

end
