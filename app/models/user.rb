class User < ApplicationRecord
  attr_accessor :salons

  has_many :teams
  has_many :favorite_teams
  has_many :fav, through: :favorite_teams, source: :team
  has_many :salon
  has_many :owners
  has_many :owned, through: :owners, class_name: 'Salon', source: :salon
  has_many :users_salons_participation
  has_many :participating, through: :users_salons_participation, class_name: 'Salon', source: :salon

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  after_create :update_access_token!

  # validates :email, presence: true

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end

  def salons
    self.salons = {
      owned: self.owned,
      participating: self.participating
    }
  end

end
