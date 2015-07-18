class Card < ActiveRecord::Base
  belongs_to :game
  has_many :active_cards
  validates :name, presence: true
  validates :picture, presence: true
  validates :attack, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :defense, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end