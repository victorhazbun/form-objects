Rails.application.routes.draw do
  root 'update_user_with_social_networks#edit'
  resource :update_user_with_social_networks, only: [:edit, :update]
end
