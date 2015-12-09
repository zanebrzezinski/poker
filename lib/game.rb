class Game

  def play
    while playing?
      deck.shuffle
      ante

      deal

      round_1

      round_2

    end
  end

  def deal
    players.each do |players|
      player.new_hand(deck)
    end
  end

  def round_1
    betting
    players.each do |player|
      player.take_turn(deck)
    end
  end


end
