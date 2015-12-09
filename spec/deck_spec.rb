require 'deck'

describe Deck do

  subject(:deck) { Deck.new }

  it "contains 52 cards" do

    expect(deck.cards.size).to eq(52)

  end

  it "contains 13 cards of each suit" do

    expect(deck.cards.select { |card| card.suit == :c }.size).to eq(13)
    expect(deck.cards.select { |card| card.suit == :d }.size).to eq(13)
    expect(deck.cards.select { |card| card.suit == :h }.size).to eq(13)
    expect(deck.cards.select { |card| card.suit == :s }.size).to eq(13)

  end

  it "contains 4 of each value" do

    hash = Hash.new(0)
    deck.cards.each { |card| hash[card.value] += 1 }
    expect(hash.all? {|k, v| v == 4}).to be(true)

  end

end
