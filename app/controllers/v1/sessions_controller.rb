module V1
  class SessionsController < ApplicationController
    # skip_before_action :authenticate_user_from_token!

    # POST /v1/login 
    # example USER --- user@example.com/ mypass
    def create
      @user = User.find_for_database_authentication(email: params[:email])

      # once error handle
      # return invalid_email unless @user
      # render json: { status: 500, message: 'メールアドレスが存在しません。' } unless @user
      if @user
        if @user.valid_password?(params[:password])
          sign_in :user, @user
          render json: @user, serializer: V1::SessionSerializer, root: nil
        else
          invalid_password
          render status: 401, json: { status: 401, message: 'パスワードが一致しません。' }
        end
      else 
        render status: 401, json: { status: 401, message: 'メールアドレスが存在しません' }
      end

    end

    private

    def invalid_email
      warden.custom_failure!
      render json: { error: t('invalid_email') }
    end

    def invalid_password
      warden.custom_failure!
      render json: { error: t('invalid_password') }
    end
  end
end