class UpdateUserWithSocialNetworksController < ApplicationController
  
  before_action :build_form, only: [:update]

  def edit
    @form = UpdateUserWithSocialNetworksForm.new(user: current_user)
    @social_networks = current_user.social_networks
  end

  def update
    @form.save
    if @form.success
      redirect_to root_path, notice: 'User was successfully updated.' 
    else
      render :edit
    end 
  end

  private

  def permitted_params
    params
      .require(:update_user_with_social_networks_form)
      .permit(:user_name, social_networks_attributes: [:id, :url])
  end 

  def build_form
    @form = UpdateUserWithSocialNetworksForm.new({
      user: current_user,
      user_name: permitted_params[:user_name],
      social_networks_attributes: permitted_params[:social_networks_attributes]
    })
  end
end