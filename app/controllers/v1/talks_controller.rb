module V1
  class TalksController < ApplicationController

    def index
      talks = LessonsTalkRoom.includes(:user, :lesson, :comments).where(user_id: params[:user_id])
      paginated_talks = pagenate(talks, params[:page])

      render json: paginated_talks, each_serializer: V1::TalkSerializer, meta: paginated_talks.total_pages
    end

    def show
      render json: LessonsTalkRoom.find(params[:id]), serializer: V1::TalkSerializer
    end

    def create
      talk = LessonsTalkRoom.new(
        user_id: params[:user_id],
        lesson_id: params[:lesson_id]
      )
      if talk.save!
        render json: {talk: talk, id: talk.id}
      else
        render 500
      end
    end

    def payment_status
      payment = LessonCommentPayment.find(params[:payment_id])
      payment.paid = !payment.paid
      payment.payment_id = params[:payment_id]
      if payment.save
        render 200
      else
        render 500
      end
    end

    def create_comment
      comment = LessonComment.new(
        talk_id: params[:id],
        user_id: params[:user_id],
        content: params[:content]
      )
      if params[:payment].present?
        comment.build_payment(
          lesson_comment_id: comment.id,
          amount: params[:payment][:amount],
          plan_id: params[:payment][:plan_id]
        )
      end
      
      if comment.save!
        render 200
      else
        render 500
      end
    end
    
    private
    def talk_params
        params.permit(
          :id,
          :user_id,
          :lesson_id,
          :payment_id,
          comment: [
            :id,
            :talk_id,
            :usre_id,
            payment: [
              :id,
              :comment_id,
              :amount,
              :plan_id
            ]
          ])
    end
  end
end
