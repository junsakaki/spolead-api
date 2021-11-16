module V1
  class Bbs::ForumsController < ApplicationController
    def index
      forum = BbsForum.all
      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_forum = forum.order(created_at: :desc).page(page).per(page_per) #execute pagenation
      total_pages = paginated_forum.total_pages #obtain all page number that paginated_teams teamss

      render json: forum, each_serializer: V1::Bbs::ForumSerializer, meta: total_pages
    end

    def create
      begin
        @forum = BbsForum.new forum_params
        @forum.save!

        render json: @forum, serializer: V1::Bbs::ForumSerializer, root: nil
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def forum_params
      params.permit(
        :name,
        :user_name,
        :content
      )
    end
  end
end
