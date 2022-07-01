module V1
  class Bbs::ThreadsController < ApplicationController

    def show
      thread = BbsThread.where(id: params[:id])
      thread.first.views_count_up!

      if(!!params[:search_word])
        thread = thread.search_columns(params[:search_word])
      end

      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_thread = thread.order(created_at: :asc).page(page).per(page_per) #execute pagenation
      total_pages = paginated_thread.total_pages #obtain all page number that paginated_teams teamss


      render json: thread, each_serializer: V1::Bbs::ThreadSerializer, parent: true, meta: total_pages
    end

    def create
      begin
        @thread = BbsThread.new thread_params
        @thread.save!

        render status: 200
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def thread_params
      params.permit(
        :name,
        :forum_id,
        :user_name,
        :content
      )
    end
  end
end