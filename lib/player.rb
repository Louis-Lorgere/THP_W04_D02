class Player
  attr_accessor :name
  attr_accessor :life_points

  def initialize player_name
    @name = player_name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage damage_delt
    @life_points -= damage_delt
    if @life_points <= 0  then puts "Le joueur #{@name} a été tué !" end
  end

  def attacks player_attacked
    puts "Le joueur #{@name} attaque le joueur #{player_attacked.name}"
    damage_delt = compute_damage
    puts "Il lui inflige #{damage_delt} points de dommages"
    player_attacked.gets_damage(damage_delt)
  end

  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player
  attr_accessor :weapon_level
  
  def initialize player_name
    @weapon_level = 1
    @name = player_name
    @life_points = 100
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    weapon_found = rand (1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_found}"
    if weapon_found > @weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      @weapon_level = weapon_found
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    search_status = rand (1..6)
    if search_status == 1
      puts "Tu n'as rien trouvé..."
    elsif search_status >= 2 && search_status <= 5
      @life_points > 50 ? @life_points = 100 : @life_points += 50
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else
      @life_points > 20 ? @life_points = 100 : @life_points += 80
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end