module V1
  class TeamsController < ApplicationController
    before_action -> {
      arr_to_str_converter("city_codes team_type target_age_type")
    }
    def index
      # team with reviews
      teams = Team.preload(:reviews)

      if params[:sports_id]
        # get Teams filtered by sportsId

        teams = teams.where(sports_id: params[:sports_id])
      elsif params[:area] && params[:area]["city_codes"]
        # get Teams filtered by cityCodes
        teams = teams.where(city_code: params[:area]["city_codes"])
      elsif params[:area] && params[:area]["latitude"] && params[:area]["longitude"]
        # # get Teams filtered by cityCodes
        team_ids = teams.all.select{|t| distance(params[:area]["latitude"], params[:area]["longitude"], t.latitude, t.longitude) <= 10}.map(&:id)
        # teams = teams.all.select{|t| distance(params[:area][:latitude], params[:area][:longitude], t.latitude, t.longitude) <= 10}
        teams = teams.where(id: team_ids)
      end

      # extract by search_word
      if(!!params[:search_word])
        teams = teams.search_columns(params[:search_word])
      end

      # pagenate logic -----------------------------------------------------------------
      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_teams = teams.order(created_at: :desc).page(page).per(page_per) #execute pagenation
      total_pages = paginated_teams.total_pages #obtain all page number that paginated_teams teamss
      # pagenate logic -----------------------------------------------------------------
      
      #meta has total_page infomation
      render json: paginated_teams, each_serializer: V1::TeamSerializer, meta: total_pages
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

    def distance(lat1, lng1, lat2, lng2)
      return 100 if lat2.blank? || lng2.blank?
      x1 = lat1.to_f * Math::PI / 180
      y1 = lng1.to_f * Math::PI / 180
      x2 = lat2.to_f * Math::PI / 180
      y2 = lng2.to_f * Math::PI / 180

      radius = 6378.137
      diff_y = (y1 - y2).abs
      calc1 = Math.cos(x2) * Math.sin(diff_y)
      calc2 = Math.cos(x1) * Math.sin(x2) - Math.sin(x1) * Math.cos(x2) * Math.cos(diff_y)
      numerator = Math.sqrt(calc1 ** 2 + calc2 ** 2)
      denominator = Math.sin(x1) * Math.sin(x2) + Math.cos(x1) * Math.cos(x2) * Math.cos(diff_y)
      degree = Math.atan2(numerator, denominator)
      degree * radius
    end

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
          :url,
          :user_id,
          area: [
            :city_codes,
            :latitude,
            :longitude
          ]
        )
    end

  end
end
