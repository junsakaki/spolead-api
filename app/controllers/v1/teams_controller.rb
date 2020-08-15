module V1
  class TeamsController < ApplicationController
    def index 
      render json: Team.all, each_serializer: V1::TeamSerializer
    end

    # to do should be added mail_address into Teams Table
    def create
      team = Team.new(teams_params)

      if team.save
        # when status OK
        render 200
      else
        # when invalid status
        render 500
      end
    end

    private
    def teams_params
        params.require(:team).permit(
          :name, 
          :mail_address,
          :team_image, 
          :sports_id, 
          :prefecture, 
          :city,
          :street_number,
          :team_type, 
          :target_age_type, 
          :team_information,           
        )
    end

  end
end
