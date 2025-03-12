require 'pqueue'
require 'json'
require 'active_support/core_ext/object/deep_dup'

class Day22
  def self.solve(input, hard_mode: false)
    boss_hp, boss_damage = parse(input)
    init = init_state(50, 500, boss_hp)
    play(init, boss_damage: boss_damage, hard_mode: hard_mode)
  end

  def self.init_state(hp, mana, boss_hp)
    {
      hp: hp,
      mana: mana,
      boss_hp: boss_hp,
      active_spells: {},
      spent_mana: 0
    }
  end

  def self.apply_fx(s, boss_turn: false)
    s[:active_spells].each_key do |spell|
      s[:boss_hp] -= spell.damage
      s[:mana] += spell.mana
      s[:hp] += spell.heal
      s[:hp] += 7 if spell.armor.positive? && boss_turn
    end
    s[:active_spells].transform_values! { |dur| dur - 1 }.reject! { |_k, dur| dur <= 0 }
  end

  def self.play(init_state, boss_damage: 8, hard_mode: false)
    pq = []
    # pq = PQueue.new { |a, b| a[:spent_mana] < b[:spent_mana] }
    visited_states = {}
    pq.push(init_state)
    result = 9999

    until pq.empty?
      s = pq.pop

      # puts "Checking state: Spent=#{s[:spent_mana]}, HP=#{s[:hp]}, BossHP=#{s[:boss_hp]}, Mana=#{s[:mana]}, Active=#{s[:active_spells].map { |k, v| [k.name, v] }}"
      s[:hp] -= 1 if hard_mode
      next if s[:hp] <= 0

      apply_fx(s)
      if s[:boss_hp] <= 0
        result = [s[:spent_mana], result].min
        next
      end

      spells.each do |spell|
        next unless spell.cost <= s[:mana] &&
                    s[:spent_mana] + spell.cost < result &&
                    s[:active_spells].keys.none?(spell)

        new_s = s.deep_dup
        new_s[:mana] -= spell.cost
        new_s[:spent_mana] += spell.cost
        new_s[:active_spells][spell] = spell.duration
        apply_fx(new_s, boss_turn: true)
        if new_s[:boss_hp] <= 0
          result = [new_s[:spent_mana], result].min
          next
        end

        new_s[:hp] -= boss_damage

        s_key = [new_s[:hp], new_s[:boss_hp], new_s[:mana], new_s[:active_spells]]
        if new_s[:hp].positive? && (visited_states[s_key].nil? || visited_states[s_key] > new_s[:spent_mana])
          visited_states[s_key] = new_s[:spent_mana]
          pq.push(new_s)
        end
      end
    end
    result
  end

  Spell = Struct.new(:name, :cost, :damage, :heal, :armor, :mana, :duration)

  def self.spells
    [
      Spell.new('missile',   53, 4, 0, 0,   0, 0),
      Spell.new('drain',     73, 2, 2, 0,   0, 0),
      Spell.new('shield',   113, 0, 0, 7,   0, 6),
      Spell.new('poison',   173, 3, 0, 0,   0, 6),
      Spell.new('recharge', 229, 0, 0, 0, 101, 5)
    ]
  end

  def self.parse(input)
    match = input.match(/Hit Points: (\d+)\nDamage: (\d+)\n/)
    [match[1].to_i, match[2].to_i]
  end
end


require 'set'

class GameState
  attr_accessor :player_hp, :boss_hp, :mana, :shield_timer, :poison_timer, :recharge_timer, :mana_spent, :player_armor

  def initialize(player_hp, boss_hp, mana, shield_timer = 0, poison_timer = 0, recharge_timer = 0, mana_spent = 0, player_armor = 0)
    @player_hp = player_hp
    @boss_hp = boss_hp
    @mana = mana
    @shield_timer = shield_timer
    @poison_timer = poison_timer
    @recharge_timer = recharge_timer
    @mana_spent = mana_spent
    @player_armor = player_armor
  end

  def apply_effects
    # Apply Poison
    @boss_hp -= 3 if @poison_timer > 0
    @poison_timer -= 1 if @poison_timer > 0

    # Apply Recharge
    @mana += 101 if @recharge_timer > 0
    @recharge_timer -= 1 if @recharge_timer > 0

    # Apply Shield
    if @shield_timer > 0
      @player_armor = 7
      @shield_timer -= 1
    else
      @player_armor = 0
    end
  end

  def boss_attack(boss_damage)
    damage = [boss_damage - @player_armor, 1].max
    @player_hp -= damage
  end

  def clone_with_changes(changes)
    GameState.new(
      changes.fetch(:player_hp, @player_hp),
      changes.fetch(:boss_hp, @boss_hp),
      changes.fetch(:mana, @mana),
      changes.fetch(:shield_timer, @shield_timer),
      changes.fetch(:poison_timer, @poison_timer),
      changes.fetch(:recharge_timer, @recharge_timer),
      changes.fetch(:mana_spent, @mana_spent),
      changes.fetch(:player_armor, @player_armor)
    )
  end

  def game_over?
    @player_hp <= 0 || @boss_hp <= 0
  end
end

class WizardBattle
  SPELLS = {
    'Magic Missile' => { cost: 53, damage: 4, heal: 0, shield: 0, poison: 0, recharge: 0 },
    'Drain'         => { cost: 73, damage: 2, heal: 2, shield: 0, poison: 0, recharge: 0 },
    'Shield'        => { cost: 113, damage: 0, heal: 0, shield: 6, poison: 0, recharge: 0 },
    'Poison'        => { cost: 173, damage: 0, heal: 0, shield: 0, poison: 6, recharge: 0 },
    'Recharge'      => { cost: 229, damage: 0, heal: 0, shield: 0, poison: 0, recharge: 5 }
  }

  def initialize(player_hp, player_mana, boss_hp, boss_damage)
    @initial_state = GameState.new(player_hp, boss_hp, player_mana)
    @boss_damage = boss_damage
  end

  def find_least_mana_win
    queue = [@initial_state]
    visited = Set.new

    until queue.empty?
      state = queue.shift # Priority queue (Dijkstra-like search)

      return state.mana_spent if state.boss_hp <= 0 # Win condition

      # Skip if already visited this exact game state
      next if visited.include?([state.player_hp, state.boss_hp, state.mana, state.shield_timer, state.poison_timer, state.recharge_timer])
      visited.add([state.player_hp, state.boss_hp, state.mana, state.shield_timer, state.poison_timer, state.recharge_timer])

      state.apply_effects
      next if state.boss_hp <= 0 # Boss defeated after effects

      SPELLS.each do |spell, effects|
        next if state.mana < effects[:cost] # Not enough mana
        next if effects[:shield] > 0 && state.shield_timer > 0 # Shield already active
        next if effects[:poison] > 0 && state.poison_timer > 0 # Poison already active
        next if effects[:recharge] > 0 && state.recharge_timer > 0 # Recharge already active

        new_state = state.clone_with_changes(
          player_hp: state.player_hp + effects[:heal],
          boss_hp: state.boss_hp - effects[:damage],
          mana: state.mana - effects[:cost],
          shield_timer: effects[:shield] > 0 ? effects[:shield] : state.shield_timer,
          poison_timer: effects[:poison] > 0 ? effects[:poison] : state.poison_timer,
          recharge_timer: effects[:recharge] > 0 ? effects[:recharge] : state.recharge_timer,
          mana_spent: state.mana_spent + effects[:cost]
        )

        new_state.apply_effects
        next if new_state.boss_hp <= 0 # Boss defeated

        new_state.boss_attack(@boss_damage)
        queue << new_state unless new_state.game_over?
      end

      queue.sort_by!(&:mana_spent) # Sort by lowest mana spent (Dijkstra-like priority queue)
    end

    Float::INFINITY # No solution found
  end
end

# Example usage:
# player_hp = 50
# player_mana = 500
# boss_hp = 58
# boss_damage = 9
#
# game = WizardBattle.new(player_hp, player_mana, boss_hp, boss_damage)
# puts "Least mana required to win: #{game.find_least_mana_win}"
