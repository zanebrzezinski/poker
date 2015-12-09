require_relative 'card'

class Deck
  SUITS = [:c, :d, :h, :s]

  attr_reader :cards

  def initialize
    @cards = shuffle_new_deck
  end

  def shuffle_new_deck
    deck = []
    SUITS.each do |suit|
      13.times do |value|
        deck << Card.new(value + 1, suit)
      end
    end
    deck.shuffle!
  end

end
