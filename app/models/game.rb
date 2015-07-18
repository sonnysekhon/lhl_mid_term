class Game < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  has_many :active_games
  validates :title, presence: true
  validates :health, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :deck_size, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :hand_size, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end