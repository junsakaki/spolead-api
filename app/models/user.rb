class User < ApplicationRecord
  attr_accessor :salons, :funds, :lessons

  has_many :teams
  has_many :favorite_teams
  has_many :fav, through: :favorite_teams, source: :team
  has_many :salon
  has_many :salon_owners
  has_many :salon_owned, through: :salon_owners, source: :salon
  has_many :users_salons_participation
  has_many :participating, through: :users_salons_participation, class_name: 'Salon', source: :salon
  has_many :fund
  has_many :fund_owners
  has_many :fund_owned, through: :fund_owners, class_name: 'Fund', source: :fund
  has_many :users_reductions_purchases
  has_many :purchases, through: :users_reductions_purchases, class_name: 'Reduction', source: :reduction, foreign_key: 'fund_id'
  has_many :matching
  has_many :matching_owners
  has_many :matching_owned, through: :matching_owners, class_name: 'Matching', source: :matching
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
      owned: self.salon_owned,
      participating: self.participating
    }
  end

  def funds
    self.funds = {
      owned: self.fund_owned,
      purchased: self.purchases
    }
  end

  def lessons
    self.lessons = self.matching_owned
  end

end
