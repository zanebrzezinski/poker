require 'hand'

describe Hand do

  subject(:hand) { Hand.new }


  it "initializes as an empty hand" do

    expect(hand.cards).to eq([])

  end

  describe "self#new_hand" do

    it "creates a new hand with five cards" do
      deck = double(:deck)
        allow(deck).to receive(:cards).and_return([:card, :card, :card, :card, :card])

      expect(Hand.new_hand(deck)).to be_a(Hand)
      expect(Hand.new_hand(deck).cards.size).to eq(5)

    end

  end

  describe "#add_card" do

    it "adds a card to the hand" do

      card = double(:card)

      hand.add_card(card)
      expect(hand.cards.size).to eq(1)

    end

    it "raises an error if the hand is full" do

      card = double(:card)
      deck = double(:deck)
        allow(deck).to receive(:cards).and_return([:card, :card, :card, :card, :card])

      new_hand = Hand.new_hand(deck)
      expect {new_hand.add_card(card)}.to raise_error(PokerError)

    end

  end

  describe "#remove_cards" do

    it "removes specified cards from the hand" do
      card = double(:card)
      deck = double(:deck)
        allow(deck).to receive(:cards).and_return([:e, :d, :c, :b, :a])

      new_hand = Hand.new_hand(deck)
      new_hand.remove_cards([0, 3])
      expect(new_hand.cards).to eq([:b, :c, :e])
    end

  end

  describe "#flush?" do

    it "returns true if all cards have the same suit" do
      card = double(:card)
        allow(card).to receive(:suit).and_return(:c)
      deck = double(:deck)
        allow(deck).to receive(:cards).and_return([card, card, card, card, card])


      new_hand = Hand.new_hand(deck)
      expect(new_hand.flush?).to eq(true)

    end

  end

  describe "#straight?" do

    it "returns true if all cards are sequential" do
      three = double(:card)
        allow(three).to receive(:value).and_return(3)
      four = double(:card)
        allow(four).to receive(:value).and_return(4)
      five = double(:card)
        allow(five).to receive(:value).and_return(5)
      six = double(:card)
        allow(six).to receive(:value).and_return(6)
      seven = double(:card)
        allow(seven).to receive(:value).and_return(7)
      deck = double(:deck)
        allow(deck).to receive(:cards).and_return([four, three, seven, five, six])


      new_hand = Hand.new_hand(deck)
      expect(new_hand.straight?).to eq(true)

    end

  end

  describe "#straight_flush?" do

    it "returns true if all cards are sequential and all cards have the same suit" do
    three = double(:card)
      allow(three).to receive(:value).and_return(3)
      allow(three).to receive(:suit).and_return(:c)
    four = double(:card)
      allow(four).to receive(:value).and_return(4)
      allow(four).to receive(:suit).and_return(:c)
    five = double(:card)
      allow(five).to receive(:value).and_return(5)
      allow(five).to receive(:suit).and_return(:c)
    six = double(:card)
      allow(six).to receive(:value).and_return(6)
      allow(six).to receive(:suit).and_return(:c)
    seven = double(:card)
      allow(seven).to receive(:value).and_return(7)
      allow(seven).to receive(:suit).and_return(:c)
    deck = double(:deck)
      allow(deck).to receive(:cards).and_return([four, three, seven, five, six])


    new_hand = Hand.new_hand(deck)
    expect(new_hand.straight?).to eq(true)
    expect(new_hand.flush?).to eq(true)

    end

  end
end
