module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at, :updated_at, :role, :salons, :funds, :lessons
    has_many :fav, key: :favorite_teams
  end
end
