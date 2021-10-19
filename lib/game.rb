class Game
  attr_accessor :ennemies
  attr_accessor :human_player
  attr_accessor :id_ennemies
  attr_accessor :player_left
  def initialize user_name
    @human_player = HumanPlayer.new(user_name)
    @ennemies = Array.new
    @id_ennemies = 1
    @player_left = 10
    4.times do
      @ennemies.push (Player.new("Saibaman No.#{@id_ennemies}"))
      @id_ennemies += 1
    end
  end

  def kill_player player
    @ennemies.delete(player)
  end

  def is_still_ongoing?
    if (@human_player.life_points > 0 && @player_left > 0)
      return true
    else
      return false
    end
  end

  def show_players 
    @human_player.show_state
    puts "\nIl reste #{@ennemies.count} saibamen en vie."
  end

  def menu
    puts "Quelle action veux-tu effectuer ?\n"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner\n"
    puts "attaquer un joueur en vue :"
    ennemy_position = 0
    @ennemies.each do |i|
      puts "#{ennemy_position} - #{i.name} a #{i.life_points} points de vie"
      ennemy_position += 1
    end
    print "> "
  end

  def menu_choice user_input
    if user_input == 'a'
      @human_player.search_weapon
    elsif user_input == 's'
      @human_player.search_health_pack
    else
      @human_player.attacks(@ennemies[user_input.to_i])
      if (@ennemies[user_input.to_i].life_points <= 0)
        kill_player(@ennemies[user_input.to_i])
        @player_left -= 1
      end
    end
  end

  def ennemies_attack
    @ennemies.each do |obj|
      if obj.life_points > 0
        obj.attacks(@human_player)
      end
    end
  end

  def end
    puts "Game Over"
    puts @human_player.life_points > 0 ? "Bravo tu le dernier Avenger, tu te sers des pierres d'infinités pour t'en faire un collier de dents de requin" : "Tu as échoué... Mais t'inquiète pas tu reviendras dans les suites en ayant perdu la mémoire"
  end

  def ennemy_spawn
    @ennemies.push (Player.new("Saibaman No.#{@id_ennemies}"))
    puts "Saibaman No.#{@id_ennemies} apparaît"
    @id_ennemies += 1
  end

  def new_players_in_sight
    if (@ennemies.length == @player_left)
      puts "Tous les saibamen sont déjà apparu !!!"
      return
    end
    dice = rand (1..6)
    if dice == 1
      puts "Aucun des Saibamen restant ne veulent venir t'affronter, t'es trop balèze ma gueule"
    elsif dice >= 2 && dice <= 4
      ennemy_spawn
    else
      2.times do
      ennemy_spawn
      end
    end
  end
end