Rails.application.routes.draw do
  devise_for :users, controllers:{sessions:'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 get "/problem", to: "jobs#problem"


  resources :jobs do
    collection do
      get :search
      get :beijing
      get :shanghai
      get :guangzhou
      get :shenzhen
      get :hangzhou

      get :jishu
      get :chanpin
      get :sheji
      get :yunying
      get :shichang
      get :guanli


    end
    resources :resumes
  end

  resources :beijing
  resources :shanghai
  resources :guangzhou
  resources :shenzhen
  resources :hangzhou





  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      collection do
        get :beijing
        get :shanghai
        get :guangzhou
        get :shenzhen
        get :hangzhou

        get :jishu
        get :chanpin
        get :sheji
        get :yunying
        get :shichang
        get :guanli
      end
      resources :resumes
    end

    namespace :beijing do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end

    namespace :shanghai do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end

    namespace :guangzhou do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end

    namespace :shenzhen do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end

    namespace :hangzhou do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end

    namespace :jishu do
      resources :jobs do
        member do
          post :publish
          post :hide
        end

        resources :resumes
      end
    end



  end





  resources :jishu
  resources :chanpin
  resources :yunying
  resources :sheji
  resources :guanli
  resources :shichang



  root "welcome#index"

end
