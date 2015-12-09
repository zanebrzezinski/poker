require 'card'

describe Card do

  subject(:card) { Card.new(2, :c) }

  it "initializes a card with value and a suit" do

    expect(card.value).to be > 0
    expect(card.value).to be < 15
    expect(card.suit).to eq(:c).or eq(:d).or eq(:s).or eq(:h)

  end

end
