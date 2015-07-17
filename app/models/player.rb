class Player < ActiveRecord::Base
  belongs_to :active_game
  has_many :active_cards
end