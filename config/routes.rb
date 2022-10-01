Rails.application.routes.draw do
  devise_for :users, path: 'accounts', path_names: {
    sign_in: 'login',
    sign_up: 'emailsignup',
    sign_out: 'logout',
    password: 'password'
  }

  devise_scope :user do
    authenticated :user do
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
