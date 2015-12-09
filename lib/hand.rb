
class PokerError < StandardError
end

class Hand

  HAND_VALUE_LEVELS = {
    :pair => 100,
    :two_pair => 1000,
    :three_pair => 10000,
    :straight => 100_000,
    :flush => 1_000_000,
    :full_house => 10_000_000,
    :four_of_a_kind => 100_000_000,
    :straight_flush => 1_000_000_000
  }

  attr_accessor :cards

  def self.new_hand(deck)
    hand = Hand.new
    5.times do
      hand.cards << deck.cards.pop
    end
    hand
  end

  def initialize
    @cards = []
  end

  def add_card(card)
    if cards.size == 5
      raise PokerError.new("THIS HAND IS FULL")
    else
      cards << card
    end
  end

  def remove_cards(card_positions)
    card_positions.each do |position|
      cards[position] = nil
    end
    cards.compact!
  end

  def value
    if flush? && straight?
      return HAND_VALUE_LEVELS[:straight_flush] + hand_value
    elsif four_of_a_kind?
      return HAND_VALUE_LEVELS[:four_of_a_kind] + hand_value
    elsif full_house?
      return HAND_VALUE_LEVELS[:full_house] + hand_value
    elsif flush?
      return HAND_VALUE_LEVELS[:flush] + hand_value
    elsif straight?
      return HAND_VALUE_LEVELS[:straight] + hand_value
    elsif three_of_a_kind?
      return HAND_VALUE_LEVELS[:three_of_a_kind] + hand_value
    elsif two_pair?
      return HAND_VALUE_LEVELS[:two_pair] + hand_value
    elsif pair?
      return HAND_VALUE_LEVELS[:pair] + hand_value
    else
      return high_card
    end
  end

  def flush?
    first_card_suit = cards.first.suit
    cards.all?{|card| card.suit == first_card_suit}
  end

  def straight?
    values = []
    cards.each {|card| values << card.value}
    values.sort!
    return true if values == [1, 10, 11, 12, 13]
    i = 0
    while i < values.size - 1
      if values[i] + 1 != values[i + 1]
        return false
      end
      i += 1
    end
    true
  end




end
