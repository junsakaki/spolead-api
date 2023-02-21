module V1
  class LessonsController < ApplicationController

    def index
      lessons = Lesson.includes(:lesson_owner).where(approval: true)
      paginated_lessons = pagenate(lessons, params[:page])

      render json: paginated_lessons, each_serializer: V1::LessonSerializer, admin: false, meta: paginated_lessons.total_pages
    end

    def manage_index
      lessons = Lesson.includes(:lesson_owner)
      paginated_lessons = pagenate(lessons, params[:page])

      render json: paginated_lessons, each_serializer: V1::LessonSerializer, admin: true, meta: paginated_lessons.total_pages
    end
    
    def show
      render json: Lesson.find(params[:id]), serializer: V1::LessonSerializer
    end

    def create
      lesson = Lesson.new(
        name: params[:name],
        caption: params[:caption],
        image_top: params[:image_top],
        image_sub: params[:image_sub],
        content: params[:content],
        background: params[:background],
        self_introduction: params[:self_introduction],
        precautions: params[:precautions],
        recruitment_target: params[:recruitment_target],
        contact_type: params[:contact_type],
        payment_type: params[:payment_type]
      )

      if params[:owner].present?
        lesson.build_lesson_owner(
          lesson_id: lesson.id,
          user_id: params[:owner][:user_id],
          name: params[:owner][:name],
          address: params[:owner][:address],
          mail_address: params[:owner][:mail_address],
          birthday: params[:owner][:birthday],
          tel: params[:owner][:tel],
          identification_1: params[:owner][:identification_1],
          identification_2: params[:owner][:identification_2],
          transfer_account: params[:owner][:transfer_account]
        )
      end
      OrganizerServiceApplyMailer.send_apply_email().deliver

      if lesson.save!
        render 200
      else
        render 500
      end
    end

    def update
      lesson = Lesson.find(params[:id])
      lesson.name = params[:name]
      lesson.caption = params[:caption]
      lesson.image_top = params[:image_top]
      lesson.image_sub = params[:image_sub]
      lesson.content = params[:content]
      lesson.background = params[:background]
      lesson.self_introduction = params[:self_introduction]
      lesson.precautions = params[:precautions]
      lesson.recruitment_target = params[:recruitment_target]
      lesson.contact_type = params[:contact_type]
      lesson.payment_type = params[:payment_type]

      lesson.lesson_owner = lesson.upsert_owner(params[:owner]) if params[:owner].present?

      if lesson.save
        render 200
      else
        render 500
      end
    end

    def approval
      lesson = Lesson.find(params[:id])
      lesson.approval = !lesson.approval
      if lesson.save
        render 200
      else
        render 500
      end
    end

    private
    def lesson_params
        params.permit(
          :id,
          :name,
          :caption,
          :image_top, 
          :iamge_sub, 
          :content, 
          :background,
          :self_introduction,
          :precautions,
          :recruitment_target,
          :contact_type,
          :payment_type,
          :user_id,
          owner: [
            :id,
            :user_id,
            :name,
            :address,
            :mail_address,
            :birthday,
            :tel,
            :identification_1,
            :identification_2,
            :transfer_account
          ])
    end  
  end
end
