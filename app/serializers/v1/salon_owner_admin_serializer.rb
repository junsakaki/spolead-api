module V1
  class SalonOwnerAdminSerializer < ActiveModel::Serializer
    attributes :name, 
      :address,
      :mail_address,
      :birthday, 
      :tel, 
      :identification_1, 
      :identification_2, 
      :transfer_account
      
  end
end
