module V1
  class TeamsController < ApplicationController
    def index 
      render json: Team.all, each_serializer: V1::TeamSerializer
    end
  end
end
