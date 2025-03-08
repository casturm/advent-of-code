require 'minitest/autorun'

require_relative './day_22'
require_relative './helpers'

class Day22Test < Minitest::Test
  def self.test_order = :alpha

  include AOC

  def setup
    @test_input = <<~INPUT
    INPUT

    @test_input = @test_input.strip

    @input = get_input(22)
  end

  def test_part_1
    game = Day22.init_game(10, 250, 13, 8)
    assert game[:effects].empty?
    assert Day22.cast_spell(game, :poison)
    assert_equal({ poison: { duration: 6 } }, game[:effects])
    refute Day22.boss_turn(game)
    assert_equal 2, game[:player_hp]
    Day22.apply_effects(game)
    assert_equal 10, game[:boss_hp]
    assert_equal({ poison: { duration: 5 } }, game[:effects])
    assert Day22.cast_spell(game, :magic_missile)
    Day22.apply_effects(game)
    assert_equal 2, game[:player_hp]
    assert_equal 3, game[:boss_hp]
    assert_equal({ poison: { duration: 4 } }, game[:effects])
    Day22.apply_effects(game)
    assert_equal 0, game[:boss_hp]
    assert_equal 2, game[:player_hp]
    assert_equal 24, game[:player_mana]

    game = Day22.init_game(10, 250, 14, 8)
    Day22.apply_effects(game)
    assert Day22.cast_spell(game, :recharge)
    assert_equal({ recharge: { duration: 5 } }, game[:effects])
    assert_equal 10, game[:player_hp]
    assert_equal 21, game[:player_mana]
    Day22.apply_effects(game)
    refute Day22.boss_turn(game)
    assert_equal 2, game[:player_hp]
    assert_equal({ recharge: { duration: 4 } }, game[:effects])
    assert_equal 122, game[:player_mana]
    Day22.apply_effects(game)
    assert Day22.cast_spell(game, :shield)
    assert_equal 110, game[:player_mana]
    assert_equal({ recharge: { duration: 3 }, shield: { duration: 6 } }, game[:effects])
    Day22.apply_effects(game)
    assert_equal({ recharge: { duration: 2 }, shield: { duration: 5 } }, game[:effects])
    refute Day22.boss_turn(game)
    Day22.apply_effects(game)
    assert_equal({ recharge: { duration: 1 }, shield: { duration: 4 } }, game[:effects])
    assert Day22.cast_spell(game, :drain)
    assert_equal 239, game[:player_mana]
    assert_equal({ recharge: { duration: 1 }, shield: { duration: 4 } }, game[:effects])
    Day22.apply_effects(game)
    assert_equal({ recharge: { duration: 0 }, shield: { duration: 3 } }, game[:effects])
    refute Day22.boss_turn(game)
    Day22.apply_effects(game)
    assert_equal({ shield: { duration: 2 } }, game[:effects])
    assert_equal 340, game[:player_mana]
    assert Day22.cast_spell(game, :poison)
    assert_equal({ shield: { duration: 2 }, poison: { duration: 6 } }, game[:effects])
    Day22.apply_effects(game)
    assert_equal({ shield: { duration: 1 }, poison: { duration: 5 } }, game[:effects])
    refute Day22.boss_turn(game)
    Day22.apply_effects(game)
    assert_equal({ shield: { duration: 0 }, poison: { duration: 4 } }, game[:effects])
    assert Day22.cast_spell(game, :magic_missile)
    Day22.apply_effects(game)
    assert_equal 1, game[:player_hp]
    assert_equal 114, game[:player_mana]
    assert_equal(-1, game[:boss_hp])

    game = Day22.init_game(10, 250, 10, 8)
    game[:effects] = { poison: { duration: 3 }, recharge: { duration: 2 } }
    Day22.apply_effects(game)
    assert_equal([7, 351], [game[:boss_hp], game[:player_mana]])

    game = Day22.init_game(10, 250, 10, 8)
    game[:effects] = { shield: { duration: 2 } } # Shield is active
    refute Day22.boss_turn(game)
    assert_equal 9, game[:player_hp]

    game = Day22.init_game(10, 500, 10, 8) # Player HP 10, Mana 500, Boss HP 10
    spells = Day22.generate_valid_spells(game)
    expected_spells = %i[poison magic_missile drain shield recharge]
    assert_equal expected_spells, spells

    game = Day22.init_game(10, 50, 10, 8) # Not enough mana for any spell
    spells = Day22.generate_valid_spells(game)
    assert spells.empty?

    game = Day22.init_game(10, 100, 10, 8) # Limited mana
    spells = Day22.generate_valid_spells(game)
    expected_spells = %i[magic_missile drain]
    assert_equal expected_spells, spells

    game = Day22.init_game(10, 500, 10, 8)
    game[:effects] = {
      shield: { duration: 3 },
      poison: { duration: 5 }
    }
    spells = Day22.generate_valid_spells(game)
    expected_spells = %i[magic_missile drain recharge]
    assert_equal expected_spells, spells

    game = Day22.init_game(10, 500, 10, 8)
    game[:effects] = {
      shield: { duration: 1 }
    }
    spells = Day22.generate_valid_spells(game)
    expected_spells = %i[poison magic_missile drain recharge] # Shield still unavailable
    assert_equal expected_spells, spells

    game = Day22.init_game(10, 500, 10, 8)
    game[:effects] = {
      recharge: { duration: 4 },
      poison: { duration: 2 }
    }
    spells = Day22.generate_valid_spells(game)
    expected_spells = %i[magic_missile drain shield]
    assert_equal expected_spells, spells

    game = Day22.init_game(10, 250, 4, 8) # Player HP 10, Mana 250, Boss HP 4, Boss Damage 8
    mana_spent = Day22.play(game, debug: true)
    assert_equal 173, mana_spent

    game = Day22.init_game(10, 250, 6, 8) # Boss HP 6
    puts "init game: #{game}"
    mana_spent = Day22.play(game, debug: true)
    assert_equal 173, mana_spent

    game = Day22.init_game(10, 53, 20, 8) # Not enough mana to win
    mana_spent = Day22.play(game, debug: true)
    assert_nil mana_spent

    answer = Day22.solve(@input)
    puts "Part 1: #{answer}"

    submit_answer(22, answer, 1)
  end

  def test_part_2
    game = Day22.init_game(50, 500, 55, 8)
    assert_equal 1415, Day22.play(game, debug: true, hard_mode: true)
    answer = Day22.solve(@input, hard_mode: true)
    puts "Part 2: #{answer}"

    submit_answer(22, answer, 2)
  end
end
