require 'pqueue'
require 'json'

class Day22
  def self.solve(input, hard_mode: false)
    boss_points, boss_damage = parse(input)
    game = init_game(50, 500, boss_points, boss_damage)
    play(game, hard_mode: hard_mode)
  end

  def self.init_game(player_hp, player_mana, boss_hp, boss_damage)
    {
      player_hp: player_hp,
      player_mana: player_mana,
      boss_hp: boss_hp,
      boss_damage: boss_damage,
      effects: {}
    }
  end

  def self.play(game, debug: false, hard_mode: false)
    visited_states = {}
    # pq = PQueue.new { |a, b| a[:mana_spent] < b[:mana_spent] }

    pq = PQueue.new do |a, b|
      if a[:state][:boss_hp] != b[:state][:boss_hp]
        a[:state][:boss_hp] < b[:state][:boss_hp]
      else
        a[:mana_spent] < b[:mana_spent]
      end
    end

    pq.push({ state: game, mana_spent: 0 })

    until pq.empty?
      current = pq.pop
      state = current[:state]
      mana_spent = current[:mana_spent]

      debug_log(debug, "Checking state: Mana Spent=#{mana_spent}, Player HP=#{state[:player_hp]}, Boss HP=#{state[:boss_hp]}, Player Mana=#{state[:player_mana]}, Effects=#{state[:effects]}")

      apply_effects(state)
      if state[:boss_hp] <= 0
        debug_log(debug, "Minimum mana required: #{mana_spent}")
        return mana_spent
      end

      if hard_mode
        state[:player_hp] -= 1
        debug_log(debug, "Hard Mode: Player HP: #{state[:player_hp]}")
        next if state[:player_hp] <= 0
      end

      valid_spells = generate_valid_spells(state)
      debug_log(debug, "Valid spells: #{valid_spells}")

      valid_spells.each do |spell|
        new_state = deep_clone(state)
        debug_log(debug, "Casting #{spell}, Boss HP: #{new_state[:boss_hp]}")

        next unless new_state[:player_hp].positive? && cast_spell(new_state, spell)

        apply_effects(new_state)

        debug_log(debug, "After spell #{spell}: Mana Spent: #{mana_spent + spell_cost[spell]}, Boss HP=#{new_state[:boss_hp]}")

        if new_state[:boss_hp] <= 0
          debug_log(debug, "Minimum mana required: #{mana_spent + spell_cost[spell]}")
          return mana_spent + spell_cost[spell]
        end

        next if boss_turn(new_state) # next if boss kills player

        new_mana_spent = mana_spent + spell_cost[spell]

        state_key = [new_state[:player_hp], new_state[:boss_hp], new_state[:player_mana], new_state[:effects].keys, new_state[:effects].values.map { |v| v[:duration] }]
        if visited_states[state_key].nil? || visited_states[state_key] > new_mana_spent
          visited_states[state_key] = new_mana_spent
          pq.push({ state: new_state, mana_spent: new_mana_spent })
        end
      end
    end

    nil
  end

  def self.debug_log(debug, message)
    puts message if debug
  end

  def self.generate_valid_spells(game)
    mana = game[:player_mana]
    all_spells = %i[magic_missile drain shield poison recharge]
    spells = all_spells.select do |spell|
      case spell
      when :shield, :poison, :recharge
        game[:effects][spell].nil? && mana >= spell_cost[spell]
      else
        mana >= spell_cost[spell]
      end
    end

    if game[:boss_hp] <= 6 && spells.include?(:poison)
      return [:poison] # Poison ensures death in 2 turns
    elsif game[:boss_hp] <= 4 && spells.include?(:magic_missile)
      return [:magic_missile] # Magic Missile can win immediately
    end

    spells.sort_by { |spell| spell_priority[spell] }
  end

  def self.boss_turn(game)
    armor = active?(:shield, game) ? 7 : 0
    game[:player_hp] -= game[:boss_damage] - armor
    puts "Boss attacks! Player HP: #{game[:player_hp]}"
    game[:player_hp] <= 0
  end

  def self.deep_clone(obj)
    JSON.parse(JSON.generate(obj), symbolize_names: true)
  end

  def self.apply_effects(game)
    game[:effects].delete_if { |_name, timer| timer[:duration].zero? }
    game[:effects].each do |effect, timer|
      puts "#{effect} #{timer}"
      game[:boss_hp] -= 3 if effect == :poison
      puts "Poison applied! New boss HP: #{game[:boss_hp]}" if effect == :poison
      game[:player_mana] += 101 if effect == :recharge
      puts "Recharge applied! New player mana: #{game[:player_mana]}" if effect == :recharge
      timer[:duration] -= 1
    end
  end

  def self.cast_spell(game, spell)
    return false if game[:boss_hp] <= 0 || game[:player_mana] < spell_cost[spell] || active?(spell, game)

    game[:player_mana] -= spell_cost[spell]
    case spell
    when :poison
      game[:effects][:poison] = { duration: 6 }
    when :shield
      game[:effects][:shield] = { duration: 6 }
    when :recharge
      game[:effects][:recharge] = { duration: 5 }
    when :magic_missile
      game[:boss_hp] -= 4
    when :drain
      game[:player_hp] += 2
      game[:boss_hp] -= 2
    end

    true
  end

  def self.spell_priority
    {
      poison: 1, # Poison should be prioritized if it will win
      magic_missile: 2, # Magic Missile should follow for quick kills
      drain: 3, # Drain is useful but not primary
      shield: 4, # Shield should only be used when needed
      recharge: 5 # Recharge is lowest priority
    }
  end

  def self.spell_cost
    {
      magic_missile: 53,
      drain: 73,
      shield: 113,
      poison: 173,
      recharge: 229
    }
  end

  def self.active?(spell, game)
    game[:effects].key?(spell) && game[:effects][spell][:duration].positive?
  end

  def self.parse(input)
    match = input.match(/Hit Points: (\d+)\nDamage: (\d+)\n/)
    [match[1].to_i, match[2].to_i]
  end
end
