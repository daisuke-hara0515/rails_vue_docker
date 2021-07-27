Rails.application.routes.draw do
  # json形式のリクエストに対応
  scope format: 'json' do
    resources :tasks
  end

  namespace :v1 do
    # mount_devise_token_auth_for 'User', at: 'auth'
    resources :tasks, only: %i(index)
    namespace 'auth' do
      post 'registrations' => 'registrations#create'
    end
  end
end
