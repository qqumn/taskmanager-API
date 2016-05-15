Rails.application.routes.draw do
  # get 'users/create'
  get 'users/updated_today' => 'users#updated_today'

  resources :projects do
    resources :tasks, except: [:new, :edit] do
      patch :assign_me, on: :member
      patch :marked_done, on: :member
    end
  end
  resources :users
  resources :sessions
  resources :comments, except: [:show]
end
