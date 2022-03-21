module V1
  class PaymentSerializer < ActiveModel::Serializer
    attributes :id, :amount, :paid, :payment_id, :plan_id
  end
end
