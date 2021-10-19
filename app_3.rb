require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "----------------------------------------------------"
puts "|Bienvenue sur 'Les Saibamen VEULENT TOUS MA POO' !|"
puts "|Le but du jeu est d'être le dernier survivant !   |"
puts "----------------------------------------------------\n"
puts "Comment tu t'intitules ?"
print "> "
human_player_name = gets.chomp
my_game = Game.new(human_player_name)
sleep 0.5
system("clear")
while (my_game.is_still_ongoing?)
  my_game.show_players
  puts
  my_game.menu
  user_input = gets.chomp
  while user_input != 'a' && user_input != 's' && (user_input.to_i < 0 || user_input.to_i >= my_game.ennemies.length)
    print "> "
    user_input = gets.chomp
  end
  system("clear")
  my_game.menu_choice(user_input)
  sleep 3
  puts
  my_game.ennemies_attack
  sleep 3
  puts
  my_game.new_players_in_sight
  sleep 2
  system("clear")
end
my_game.end