Rails.application.routes.draw do

  mount ActionCable.server => '/cable/'

# Chat
  resources :chatrooms, only: [:show, :destroy, :create]
  post '/chatrooms/:id/messages' => 'messages#create', :as => 'chatroom_messages'
  post '/chatrooms/finished'

  # Admins
  devise_for :admins, :skip => [:registrations]
  get 'admins/index'
  authenticated :admin do
    root 'admins#index'
  end

  # Tutors
  devise_for :tutors, :skip => [:registrations], controllers: {sessions: 'tutors/sessions'}
  as :tutor do
    get 'tutors/edit' => 'devise/registrations#edit', :as => 'edit_tutor_registration'
    put 'tutors' => 'devise/registrations#update', :as => 'tutor_registration'
  end
  get 'tutors/account'
  post 'tutors/payment'
  post 'tutors/rate'
  namespace :tutors do
    get 'notifications/index'
    resources :timeslots, only: [:show, :destroy, :create, :new]
    get 'timeslots' => "timeslots#index"
  end
  authenticated :tutor do
    root 'tutors#index'
  end

  # Users
  devise_for :users, controllers: { registrations: 'users/registrations'}
  get 'users/index'
  get 'users/rate'
  get 'users/new_session'
  post 'users/request_session'
  get 'users/new_chat'
  authenticated :user do
    root 'users#index'
  end

  # Application
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
