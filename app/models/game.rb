class Game < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  has_many :active_games
end