require_relative './player'
require_relative './score'
require 'pry'

class Pig
  def initialize
    @players   = []
    @max_score = 10
    @scores = []
    @losers = []
    @winners = []
  end

  def get_players
    puts "Getting player names. Type q when done."
    loop do
      print "Player #{@players.count + 1}, what is your name? > "
      input = gets.chomp
      if input == "q" || input == ""
        return
      else
        @players.push Player.new(input)
        @score = Score.find_or_create_by(player_name: "#{input}")
        @scores.push(@score)
      end
    end
  end

  def play_round
    @players.each do |p|
      puts "-" * 20
      puts "\n\nIt is #{p.name}'s turn! You have #{p.score} points. (Press ENTER)"
      gets
      take_turn p
    end
    remove_losing_players!
  end

  def remove_losing_players!
    if @players.any? { |p| p.score > @max_score }
      max_score = @players.map { |p| p.score }.max
      @players = @players.select { |p| p.score == max_score }
      @scores.each do |score|
        if score.player_name == @players.first.name
          @winners.push(score)
        else
          @losers.push(score)
        end
      end
    end
  end

  def increase_losses
    @losers.each do |loser|
      loser.losses += 1
      loser.save!
    end
  end

  def increase_wins
    @winners.each do |winner|
      winner.wins += 1
      winner.save!
    end
  end

  def winner
    if @players.length == 1
      @players.first
    end
  end

  def take_turn player
    turn_total = 0
    loop do
      roll = rand 1..6
      if roll == 1
        puts "You rolled a 1. No points for you!"
        return
      else
        turn_total += roll
        puts "You rolled a #{roll}. Turn total is #{turn_total}. Again? (y/n)"
        if gets.chomp.downcase == "n"
          puts "Stopping with #{turn_total} for the turn."
          player.score += turn_total
          return
        end
      end
    end
  end
end



































