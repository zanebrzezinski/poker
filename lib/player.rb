class player

  attr_accessor :hand

  def initialize

  end

  def new_hand(deck)
    @hand = Hand.new_hand(deck)
  end

  def take_turn(deck)
    puts "select what cards you hate"
    positions = gets.chomp

    hand.remove_cards(positions)
    hand.add_cards(deck)
  end

end
