require 'pry'
require 'pry-byebug'

class Player
  CARD_NUM_VALUES = { two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10,
  jack: 10, queen: 10, king: 10, ace: 11 }
  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
    @hand = []
  end

  def hit(card)
    @hand << card
  end

  def stay
  end

  def busted?
    total > 21
  end

  def total
    aces_count = @hand.count { |card| card.value == :ace }
    sum = @hand.map { |card| CARD_NUM_VALUES[card.value] }.sum

    while sum > 21 && aces_count > 0
      sum -= 10
      aces_count -= 1
    end

    sum
  end

  def reset_hand
    @hand = []
  end

  def cards
    cards = @hand.map { |card| card.value.to_s }
    "hand: #{cards.join(', ')}"
  end
end

class Dealer < Player
  def initial_cards
    "hand: #{@hand.first.value}, HIDDEN"
  end
end


class Participant
  # what goes in here? all the redundant behaviors from Player and Dealer?
end

class Deck
  #attr_reader :cards
  SUITS = [:spade, :club, :heart, :diamond]
  VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| @cards << Card.new(suit, value) }
    end
  end

  def take_card
    # does the dealer or the deck deal?
    card = @cards.sample
    @cards.delete(card)
    card
  end
end

class Card
  attr_reader :suit
  def initialize(suit, value)
    # what are the "states" of a card?
    @suit = suit
    @value = value
  end

  def value
    @value
  end

  def to_s
    "#{value.to_s} of #{suit.to_s}s"
  end
end

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_cards
    2.times do |_|
      @player.hit(@deck.take_card)
      @dealer.hit(@deck.take_card)
    end
  end

  def show_initial_cards
    puts "Player " + @player.cards
    puts "Dealer " + @dealer.initial_cards
  end

  def player_hit?
    puts "Would you like to 'hit' or 'stay'?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer == 'hit' || answer == 'stay'
      puts "Wrong input! Options: 'hit' or 'stay'."
    end
    answer == 'hit'
  end

  def player_turn
    loop do
      if player_hit?
        @player.hit(@deck.take_card)
        puts "Player score so far: #{@player.total}"
        puts @player.cards
        if @player.busted?
          puts "Player busted! ;P"
          break
        end
      else
        puts "Player stayed!"
        break
      end
    end
  end

  def dealer_turn
    # START WORKING HERE
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start