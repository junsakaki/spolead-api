module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at, :updated_at
    has_many :fav, key: :favorite_teams
  end
end
