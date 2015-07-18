require 'byebug'

class ServerPlayer

  attr_reader :id, :hand, :deck, :name
  attr_accessor :health

  def initialize(id, health)
    @id = id
    @name = id
    @health = health
    @deck = []
    @hand = []
  end

  def alive?
    health > 0
  end

  def pickup
    card = deck.shift
    hand << card
  end

  def play_card(card_position)
    hand.delete_at(card_position)
  end

end