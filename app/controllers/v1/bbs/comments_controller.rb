module V1
  class Bbs::CommentsController < ApplicationController

    def show
      comment = BbsComment.find(params[:id])
      # thread = comment.bbs_thread
      # thread.views_count_up!

      if(!!params[:search_word])
        comment = comment.search_columns(params[:search_word])
      end

      render json: comment, serializer: V1::Bbs::CommentSerializer
    end

    def create
      begin
        @comment = BbsComment.new comment_params
        @comment.save!

        render status: 200
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.permit(
        :user_name,
        :thread_id,
        :content,
        :search_word,
        :reply_to
      )
    end
  end
end