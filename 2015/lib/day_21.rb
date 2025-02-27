class Day21
  def self.part_1(input, player_points)
    run(input, player_points).select(&:first).map(&:last).min
  end

  def self.parse(input)
    match = input.match(/Hit Points: (\d+)\nDamage: (\d+)\nArmor: (\d+)\n/)
    [match[1].to_i, match[2].to_i, match[3].to_i]
  end

  def self.store
    {
      Weapons: { #    Cost  Damage  Armor
        Dagger: [8, 4, 0],
        Shortsword: [10, 5, 0],
        Warhammer: [25, 6, 0],
        Longsword: [40, 7, 0],
        Greataxe: [74, 8, 0]
      },
      Armor: {
        None: [0, 0, 0],
        Leather: [13, 0, 1],
        Chainmail: [31, 0, 2],
        Splintmail: [53, 0, 3],
        Bandedmail: [75, 0, 4],
        Platemail: [102, 0, 5]
      },
      Rings: {
        None: [0, 0, 0],
        Damage1: [25, 1, 0],
        Damage2: [50, 2, 0],
        Damage3: [100, 3, 0],
        Defense1: [20, 0, 1],
        Defense2: [40, 0, 2],
        Defense3: [80, 0, 3]
      }
    }
  end

  def self.run(input, player_points)
    boss_points, boss_damage, boss_armor = parse(input)
    trials = []
    rings = store[:Rings].values
    rings2 = rings[1..]
    rings.concat(rings2.combination(2).map { |r1, r2| r1.zip(r2).map(&:sum) })

    store[:Weapons].each_value do |w_stats|
      store[:Armor].each_value do |a_stats|
        rings.each do |ring_stats|
          trials << [w_stats, a_stats, ring_stats]
        end
      end
    end

    scores = []
    trials.each do |items|
      gold = items.sum { |s| s[0] }
      player_damage = items.sum { |s| s[1] }
      player_armor = items.sum { |s| s[2] }

      game = {
        player: { points: player_points, damage: player_damage, armor: player_armor },
        boss: { points: boss_points, damage: boss_damage, armor: boss_armor }
      }
      scores << [run_trial(game), gold]
    end

    scores
  end

  def self.run_trial(game)
    player = game[:player]
    boss = game[:boss]

    while player[:points].positive? && boss[:points].positive?
      boss[:points] -= player[:damage] - boss[:armor] unless player[:points] <= 0
      player[:points] -= boss[:damage] - player[:armor] unless boss[:points] <= 0
    end

    player[:points] > boss[:points]
  end

  def self.part_2(input, player_points)
    run(input, player_points).reject(&:first).map(&:last).max
  end
end
