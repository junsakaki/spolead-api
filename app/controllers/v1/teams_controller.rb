module V1
  class TeamsController < ApplicationController
    def index 
      render json: Team.all, each_serializer: V1::TeamSerializer
    end

    # to do should be added mail_address into Teams Table
    def create
      binding.pry
      # binding.pry
      # team = Team.new(params[:team])
      # if team.save
      #   # hogehoge
      # else
      #   # hogehoge
      # endS
    end
  end
end
