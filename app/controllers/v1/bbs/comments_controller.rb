module V1
  class Bbs::CommentsController < ApplicationController

    def show
      thread = BbsThread.includes(:bbs_comments).find(params[:id])
      thread.views_count_up!
      comment = thread.bbs_comments
      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_comment = comment.order(created_at: :desc).page(page).per(page_per) #execute pagenation
      total_pages = paginated_comment.total_pages #obtain all page number that paginated_teams teamss


      render json: comment, each_serializer: V1::Bbs::CommentSerializer, meta: total_pages
    end

    def create
      begin
        @comment = BbsComment.new comment_params
        @comment.save!

        render json: @comment, serializer: V1::Bbs::CommentSerializer, root: nil
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.permit(
        :user_name,
        :bbs_thread_id,
        :content
      )
    end
  end
end