module V1
  class UsersController < ApplicationController
    # skip_before_action :authenticate_user_from_token!, only: [:create]

    def index
      render json: User.all, each_serializer: V1::UserSerializer
    end

    # POST
    # Create an user
    def create
      @user = User.new user_params
      
      if @user.save!
        sign_in :user, @user # login automaticaly
        @user = User.find_for_database_authentication(email: @user.email)

        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    def show
      user = User.includes(:teams).find(params[:id])
      if user.blank?
        render 404
      else
        render json: user, each_serializer: V1::UserSerializer
      end
    end

    private

    def user_params
      params.permit(:nickname, :email, :password)
    end
  end
end