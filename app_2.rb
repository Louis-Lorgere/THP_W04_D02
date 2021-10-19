require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "----------------------------------------------------"
puts "|Bienvenue sur 'Les Avengers VEULENT TOUS MA POO' !|"
puts "|Le but du jeu est d'être le dernier survivant !   |"
puts "----------------------------------------------------\n"

puts "Comment tu t'intitules ?"
print ">"
human_player_name = gets.chomp
hplayer1 = HumanPlayer.new(human_player_name)
player1 = Player.new("Iron Man")
player2 = Player.new("Captain America")
array_players = [player1, player2]
while ((array_players[0].life_points > 0 || array_players[1].life_points > 0) && hplayer1.life_points > 0)
  hplayer1.show_state
  puts "Quelle action veux-tu effectuer ?\n"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner\n"
  puts "attaquer un joueur en vue :"
  puts "0 - #{array_players[0].name} a #{array_players[0].life_points} points de vie"
  puts "1 - #{array_players[1].name} a #{array_players[1].life_points} points de vie\n"
  print ">"
  user_input = gets.chomp
  while user_input != 'a' && user_input != 's' && user_input != '0' && user_input != '1'
    print ">"
    user_input = gets.chomp
  end
  puts
  if user_input == 'a'
    hplayer1.search_weapon
  elsif user_input == 's'
    hplayer1.search_health_pack
  elsif user_input == '0'
    hplayer1.attacks(array_players[0])
  else
    hplayer1.attacks(array_players[1])
  end
  puts
  array_players.each do |obj|
    if obj.life_points > 0
      obj.attacks(hplayer1)
    end
  end
end

puts "Game Over"
puts hplayer1.life_points > 0 ? "Bravo tu le dernier Avenger, tu te sers des pierres d'infinités pour t'en faire un collier de dents de requin" : "Tu as échoué... Mais t'inquiète pas tu reviendras dans les suites en ayant perdu la mémoire"
