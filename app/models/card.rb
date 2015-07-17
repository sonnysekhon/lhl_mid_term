class Card < ActiveRecord::Base
  belongs_to :game
  has_many :active_cards
end