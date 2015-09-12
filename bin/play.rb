require_relative '../db/setup'
require_relative '../lib/all'
require_relative '../lib/pig'
require_relative '../lib/hog'
require 'pry'

def select_from(hash)
  loop do
    hash.each do |key, value|
      puts "#{key}) #{value}"
    end
    print "? > "
    input = gets.chomp
    found = hash.find { |k,v| k.to_s == input || v.to_s == input }
    if found
      return found.last
    else
      puts "Invalid selection: #{input}. Please try again."
    end
  end
end

#Pig and Hog are class constants
game_classes = {
  1 => Pig,
  2 => Hog,
  3 => "Leaderboard"
}

game_class = select_from(game_classes)

scores = []

if game_class == Pig || game_class == Hog
  puts "Playing a game of #{game_class}"
  game = game_class.new
#      ^ game class is either Pig or Hog. The constant of a class can be assigned to a local variable and be used like any other local variable

  game.get_players

  game.play_round until game.winner
  game.increase_losses
  game.increase_wins
  puts "#{game.winner} wins!"
elsif game_class == "Leaderboard"
  puts "\nDisplaying leaderboard\n\n"

  Score.find_each do |score|
    scores.push(score)
  end
  puts "Player Name     Wins    Losses"
  puts "-" * 30
  scores.each do |score|
    puts "#{score.player_name} \t \t #{score.wins} \t   #{score.losses} "
  end
end
















