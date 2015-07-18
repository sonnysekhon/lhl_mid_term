class ServerCard

  attr_reader :id, :name, :attack
  attr_accessor :health

  def initialize(card_id)
    @id = card_id
    @name = "Card.find(id).name"
    @img = "Card.find(id).img"
    @attack = 1
    @health = 1
  end

  def damage(target)
    if target.alive?
      target.health -= attack
    else
      false
    end
  end

  def alive?
    health > 0
  end

end