
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

  attr_accessor :cards, :hand_value

  def self.new_hand(deck)
    hand = Hand.new
    5.times do
      hand.cards << deck.cards.pop
    end
    hand
  end

  def initialize
    @cards = []
    @hand_value = 0
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
    if cards.all?{|card| card.suit == first_card_suit}
      @hand_value = high_card
      return true
    end
    false
  end

  def straight?
    values = []
    cards.each {|card| values << card.value}
    values.sort!
    #if high ace, hand_value is 14
    if values == [1, 10, 11, 12, 13]
      @hand_value = 14
      return true
    end

    i = 0
    while i < values.size - 1
      if values[i] + 1 != values[i + 1]
        return false
      end
      i += 1
    end
    @hand_value = high_card
    true
  end

  def four_of_a_kind?
    value_hash = Hash.new(0)
    cards.each do |card|
      value_hash[card.value] += 1
    end
    value_hash.select! { |k, v| v == 4 }
    if value_hash.size == 1
      value_hash.each do |k, v|
        @hand_value = k * v
      end
      return true
    end
    false
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def three_of_a_kind?
    value_hash = Hash.new(0)
    cards.each do |card|
      value_hash[card.value] += 1
    end
    value_hash.select! { |k, v| v == 3 }
    if value_hash.size == 1
      value_hash.each do |k, v|
        @hand_value = k * v
      end
      return true
    end
    false
  end

  def two_pair?
    value_hash = Hash.new(0)
    cards.each do |card|
      value_hash[card.value] += 1
    end
    value_hash.select! { |k, v| v == 2 }
    if value_hash.size == 2
      value_hash.each do |k, v|
        @hand_value = k * v
      end
      return true
    end
    false
  end

  def pair?
    value_hash = Hash.new(0)
    cards.each do |card|
      value_hash[card.value] += 1
    end
    value_hash.select! { |k, v| v == 2 }

    if value_hash.size == 1
      value_hash.each do |k, v|
        @hand_value += k * v
      end
      return true
    end

    false

  end

  def high_card
    values = []
    cards.each {|card| values << card.value}
    values.sort!
    values.last
  end

end
