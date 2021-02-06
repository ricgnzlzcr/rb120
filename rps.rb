class Moves
  OPTIONS = { :rock => [:scissors], :scissors => [:paper], :paper => [:rock] }
end


class Player
  attr_accessor :current_hand, :wins
  def initialize
    @current_hand = nil
    @wins = 0
  end

end

class Human < Player
  def play
    choice = nil
    loop do
      puts "Pick a number 1-3 to make a move: 1 = Rock, 2 = Scissors, 3 = Paper"
      choice = gets.chomp.to_i
      break if [1, 2, 3].include? choice
      puts "Come on! Pick a valid number!"
    end
    self.current_hand = Moves::OPTIONS.keys[choice - 1]
    puts "You chose #{self.current_hand}."
  end
end

class Computer < Player
  def play
    self.current_hand = Moves::OPTIONS.keys.sample
    puts "The computer chose #{self.current_hand}."
  end
end



class RPSGame
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    print_welcome_message
    loop do
      play_round
      print_score
      break if max_wins? || !play_again?
    end
    print_goodbye_message
  end
  
  def print_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def compute_winner(player1, player2)
    if Moves::OPTIONS[player1.current_hand].include? player2.current_hand
      player1.wins = player1.wins + 1
      puts "You win!"
    elsif Moves::OPTIONS[player2.current_hand].include? player1.current_hand
      player2.wins = player2.wins + 1
      puts "Computer won!"
    else
      puts "Tie!"
    end
  end

  def play_round
    @human.play
    @computer.play
    compute_winner(@human, @computer)
  end

  def print_score
    puts "Current score:"
    puts ">> Player: #{@human.wins}"
    puts ">> Computer: #{@computer.wins}" 
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Invalid answer!"
    end
    answer == 'y'
  end

  def max_wins?
      max_played = @human.wins == 2 || @computer.wins == 2
  end

  def print_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
  end


end


RPSGame.new.play