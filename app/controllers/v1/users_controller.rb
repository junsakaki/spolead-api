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
      @user.role = 'member'
      
      if @user.save!
        sign_in :user, @user # login automaticaly
        @user = User.find_for_database_authentication(email: @user.email)

        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    def show
      if params[:id].include?('|')
        user = User.includes(:teams).find_by(social_login_id: params[:id])
        if user.blank?
          user = User.new(
            social_login_id: params[:id]
          )
          if user.save!
          render json: user, each_serializer: V1::UserSerializer
          else
            render json: { error: t('user_create_error') }, status: :unprocessable_entity
          end
        else
          render json: user, each_serializer: V1::UserSerializer
        end
      else
        user = User.includes(:teams).find(params[:id])
        if user.blank?
          render 404
        else
          render json: user, each_serializer: V1::UserSerializer
        end
      end
    end

    def update 
      @user = User.find(params[:id])
      if @user.update(user_params)
        render 200
      else
        render json: { error: t('user_info_update_error') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:nickname, :email, :password, :tel)
    end
  end
end