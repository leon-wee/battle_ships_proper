class Ship

  attr_reader :size
  attr_accessor :hits

  def initialize size
    @size = size
    @hits = 0
  end

  def sunk?
    @hits == @size
  end

  def get_hit
    @hits += 1
  end

  def self.boat
    Ship.new 2
  end

  def self.submarine
    Ship.new 3
  end

  def self.destroyer
    Ship.new 3
  end

  def self.warrior
    Ship.new 4
  end

  def self.aircraft_carrier
    Ship.new 5
  end

end