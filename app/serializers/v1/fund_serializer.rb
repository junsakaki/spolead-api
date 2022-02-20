module V1
  class FundSerializer < ActiveModel::Serializer
    attributes :id, 
      :name,
      :caption,
      :image_top, 
      :image_sub, 
      :content, 
      :background, 
      :self_introduction,
      :precautions,
      :target_money,
      :limit_date,
      :owner,
      :supported_money,
      :supporters_count

    attribute :approval, if: -> { instance_options[:admin?] }

    def initialize(object, options = {})
      super
      @options = options
      @admin = options[:admin]
    end

    def owner
      if object.fund_owner.present?
        if @admin 
          object.fund_owner
        else
          {name: object.fund_owner.name}
        end  
      end
    end

    has_many :reductions, serializer: V1::ReductionSerializer
  end
end
