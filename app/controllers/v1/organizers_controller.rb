module V1
  class OrganizersController < ApplicationController
    # before_action :authenticate_user_from_token!, except: [:create, :apply, :reset, :create_withdrawals]
    require 'securerandom'

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

    def reset
      begin
          @user = User.find_by(email: params[:email], role: 'organizer') 
          new_password = SecureRandom.alphanumeric
          @user.password = new_password
          @user.password_confirmation = new_password
        if @user.save!
          PasswordResetMailer.send_reset_email(@user, new_password).deliver
          render status: 200
        else
          render json: { error: 'organizer_reset_passowrd_error' }, status: :unprocessable_entity
        end
      rescue
        if @user.blank?
          render json: { error: 'missiing organizer with request email'}, status: :not_found if @user.blank? 
        else
          render json: { error: 'organizer_reset_passowrd_error' }, status: :unprocessable_entity
        end
      end
  end

    def show
      @user = User.find(params[:id]) 
      render json: @user, serializer: V1::OrganizerSerializer, root: nil
    end

    def reports
      Rails.logger.debug("-aaa-----------------")
      @user = User.find(params[:userId]) 

      term = params[:term_year].present? ? Date.new(params[:term_year].to_i, params[:term_month].to_i) : nil
      total = {
        salons: calc_salons,
        funds: calc_funds,
        # lessons: @user.lesson_owned.present? ? @user.lesson_owned.map{|lesson|
        #   {id: lesson.id,  amount: lesson.lesson_amount}
        # } :  []
      }
      term = term.nil? ? nil : {
        salons: calc_salons(term),
        # funds: calc_funds(term),
        # lessons: @user.lesson_owned.map{|lesson|
        #   {id: lesson.id,  amount: lesson.lesson_amount(term)}
        # }
      }
      render json: {total: total, term: term}
    end

    def withdrawals
      organizer = User.includes(:organizer_withdrawal).find(params[:userId])
      item = organizer.organizer_withdrawal.where("amount < ?", 0).select(:amount, :content, :created_at).map{|withdrawal|
        withdrawal_attr = withdrawal.attributes
        withdrawal_attr["amount"] = withdrawal_attr["amount"] * -1
        withdrawal_attr.delete("id")
        withdrawal_attr
      }
      render json: {item: item}
    end

    def apply
      organizer_info = {
        name: params["name"],
        email: params["email"],
        phone_number: params["phone_number"],
        desired_service: params["desired_service"].join(",")
      }
      OrganizerApplyMailer.send_apply_email(organizer_info).deliver
      render status: 200
    end

    def create_withdrawals
      organizer = User.find(params["id"])
      OrganizerPool.create!({
        content: params["content"],
        amount: params["amount"],
        organizer: organizer,
        month: Time.new.strftime("%Y%m")
      })
      render status: 200
    end

    def request_withdrawals
      RequestWithdrawalMailer.send_request_email(params["userId"],params["account"], params["amount"]).deliver
      render status: 200
    end
    
    private

    def organizer_params
      params.permit(:nickname, :email, :password, :tel)
    end

    def calc_salons(term = nil)

      @calc_salons = []
      @user.salon_owned.map{|salon|
        participations = term.present? ? salon.participations.where(created_at: (term)..(term.end_of_month)) : salon.participations
        participations = participations.group_by{|p| p[:plan_id]}.values
       
        amount = 0
        if participations.present?
          plan_amounts = participations.map{|participation|
            participation.each{|p| amount += p.amount * p.count}
          }
        end
        @calc_salons.push({salon: salon ,total_amount: amount})
      }
      return @calc_salons
    end

    def calc_funds(term = nil)
      @user.fund_owned.map{|fund|
        reductions = fund.reductions
        reductions = term.present? ? reductions.map{|r| r.purchases.where(created_at: (term)..(term.end_of_month))} : reductions.map{|r| r.purchases}
        if reductions.first.present?
          reduction_amounts = reductions.map{|reduction|
            amount = 0
            reduction.each{|r| amount += r.amount * r.count}
            return {id: reduction.first.reduction_id, amount: amount}
          }        
        end
        return {id: fund.id, plans: reduction_amounts} 
      } 
    end
  end
end