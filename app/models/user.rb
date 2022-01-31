class User < ApplicationRecord
  has_many :teams
  has_many :favorite_teams
  has_many :fav, through: :favorite_teams, source: :team

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  after_create :update_access_token!

  # validates :email, presence: true

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

end
