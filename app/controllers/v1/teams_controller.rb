module V1
  class TeamsController < ApplicationController
    def index
      # team with reviews
      teams = Team.preload(:reviews)

      if params[:sports_id]
        # get Teams filtered by sportsId
        teams = teams.where(sports_id: params[:sports_id])
      elsif params[:city_code]
        # get Teams filtered by cityCodes
        teams = Team.where(city_code: params[:city_code])
      end

      # extract by search_word
      if(!!params[:search_word])
        teams = teams.search_columns(params[:search_word])
      end

      # pagenate logic -----------------------------------------------------------------
      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_teams = teams.page(page).per(page_per) #execute pagenation
      total_pages = paginated_teams.total_pages #obtain all page number that paginated_teams teamss
      # pagenate logic -----------------------------------------------------------------
      
      response = {
        teams: paginated_teams.order(created_at: :desc), each_serializer: V1::TeamSerializer,
        total_pages: total_pages 
      }
      # binding.pry
      render json: response

    end
    
    def show
      render json: Team.find_by(id: params[:team_id]), each_serializer: V1::TeamSerializer
    end

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

    def update
      team = Team.find_by(id: teams_params[:id])

      team.update(teams_params)
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
          :id,
          :name, 
          :mail_address,
          :team_image, 
          :sports_id, 
          :prefecture_code, 
          :prefecture, 
          :city_code,
          :city,
          :street_number,
          :team_type, 
          :target_age_type, 
          :team_information,
          :search_word,
          :page,
          :user_id
        )
    end

  end
end
