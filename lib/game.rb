class Game

  attr_reader :deck
  attr_accessor :players, :pot, :current_bet

  def initialize(players_array)
    @players = players
  end

  def play
    while playing?
      @deck = Deck.new
      @pot = 0

      ante

      deal

      betting_round
      exchange_round
      betting_round

      winner_index = reveal

      puts "Winner is #{players[winner_index]}"



    end
  end

  def ante
    players.each do |player|
      player.ante
      @pot += 5
    end
  end

  def playing?
    if players.size <= 1
      return false
    end
    true
  end

  def deal
    players.each do |players|
      player.new_hand(deck)
    end
  end

  def exchange_round
    players.each do |player|
      puts "#{player.name}\'s turn to exchange cards!"
      player.exchange_cards(deck)
    end
  end


  def reveal
    high_hand = 0
    players.each_with_index do |player, index|
      next if player.folded?
      if player.hand_value > high_hand
        high_hand = player.hand_value
        winner_index = index
      end
    end
    winner_index
  end

  def betting_round
    @current_bet = 0
    until players.all? { |player| player.called? || player.folded?}
      players.each do |player|
        puts "#{player.name}\'s turn to bet!"
        player_bet = player.bet
        raise PokerError.new("Bet More") if player_bet < current_bet
        @current_bet = player_bet
        @pot += current_bet
      end
    end
  end


end
