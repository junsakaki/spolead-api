module V1
  class OwnerAdminSerializer < ActiveModel::Serializer
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
