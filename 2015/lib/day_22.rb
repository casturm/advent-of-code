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
