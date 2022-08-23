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
      term = params[:term].present? ? Date.new(params[:term][:year].to_i, params[:term][:month].to_i) : nil
      total = {
        salons: calc_salons,
        funds: calc_funds,
        lessons: @user.lesson_owned.present? ? @user.lesson_owned.map{|lesson|
          {id: lesson.id,  amount: lesson.lesson_amount}
        } :  nil
      }
      term = term.nil? ? nil : {
        salons: calc_salons(term),
        funds: calc_funds(term),
        lessons: @user.lesson_owned.map{|lesson|
          {id: lesson.id,  amount: lesson.lesson_amount(term)}
        }
      }
      render json: {total: total, term: term}
    end

    def withdrawals
    end
    
    private

    def organizer_params
      params.permit(:nickname, :email, :password, :tel)
    end

    def calc_salons(term = nil)
      @user.salon_owned.map{|salon|
        participations = term.present? ? salon.participations.where(created_at: (term)..(term.end_of_month)) : salon.participations
        participations = participations.group_by{|p| p[:plan_id]}.values
        if participations.present?
          plan_amounts = participations.map{|participation|
            amount = 0
            participation.each{|p| amount += p.amount * p.count}
            return {id: participation.first.plan_id, amount: amount}
          }        
        end
        return {id: salon.id, plans: plan_amounts} 
      }
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