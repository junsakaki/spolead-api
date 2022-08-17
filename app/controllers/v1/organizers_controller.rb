module V1
  class OrganizersController < ApplicationController
    before_action :authenticate_user_from_token!, except: :create

    # POST
    # Create an organizer
    def create
      @user = User.new organizer_params
      @user.role = 'organizer'
      
      if @user.save!
        sign_in :user, @user # login automaticaly
        @user = User.find_for_database_authentication(email: @user.email)

        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end


    def update 
      @user = User.find(params[:id]) 
      if params[:target] == "email"
        @user.email = params[:email]
      else
        @user.password = params[:password]
        @user.password_confirmation = params[:password]
      end
      if @user.save!
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('organizer_update_error') }, status: :unprocessable_entity
      end
    end

    def show
      @user = User.find(params[:id]) 
      render json: @user, serializer: V1::OrganizerSerializer, root: nil
    end

    def reports
      @user = User.find(params[:userId]) 
      puts "@user: #{@user.inspect}" 
      term = params[:term].present? ? Date.new(params[:term][:year].to_i, params[:term][:month].to_i) : nil
      if term.present?
        term_reports = {
          salons: @user.salon_owned.where(created_at: (term)..(term.end_of_month)).includes(:plans),
          funds: @user.fund_owned.where(created_at: (term)..(term.end_of_month)).includes(:reductions),
          lessons: @user.lesson_owned.where(created_at: (term)..(term.end_of_month)),
        }
      end
    end

    def withdrawals
    end
    
    private

    def organizer_params
      params.permit(:nickname, :email, :password, :tel)
    end
  end
end