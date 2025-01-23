# frozen_string_literal: true

require 'dotenv/load'
require 'net/http'
require 'fileutils'

module AOC
  # AOC Interaction
  def get_input(day)
    file_name = "./inputs/day#{day}.txt"
    if File.exist?(file_name)
      File.read(file_name)
    else
      puts 'Requesting input from adventofcode.com'
      res = Net::HTTP.get_response(URI("https://adventofcode.com/#{ENV['AOC_YEAR'] || 2024}/day/#{day}/input"),
                                   { Cookie: "session=#{ENV['AOC_SESSION']}",
                                     'User-Agent' => 'Chris Sturm <casturm@gmail.com>' })
      body = res.body

      if body.strip == "Please don't repeatedly request this endpoint before it unlocks! The calendar countdown is synchronized with the server time; the link will be enabled on the calendar the instant this puzzle becomes available."
        raise 'Puzzle input not open'
      end

      FileUtils.mkdir_p(File.dirname(file_name))
      File.write(file_name, body)

      body
    end
  end

  def can_submit?(day, level)
    file_name = "./inputs/day-#{day}-#{level}.txt"
    return false if File.exist?(file_name)

    body = Net::HTTP.get(URI("https://adventofcode.com/#{ENV['AOC_YEAR'] || 2024}/day/#{day}"),
                         { Cookie: "session=#{ENV['AOC_SESSION']}", 'User-Agent' => 'Chris Sturm <casturm@gmail.com>' })

    return true if body.include?("name=\"level\" value=\"#{level}\"")

    File.write(file_name, body) unless level == 2 && body.include?('name="level" value="1"')

    false
  end

  def submit_answer(day, answer, level)
    return unless can_submit?(day, level)

    puts "Submit Day #{day}, Level #{level}: #{answer}? [y/n]"

    a = gets.chomp

    return if a[0].downcase != 'y'

    res = Net::HTTP.post(URI("https://adventofcode.com/#{ENV['AOC_YEAR'] || 2024}/day/#{day}/answer"),
                         "level=#{level}&answer=#{answer}", { Cookie: "session=#{ENV['AOC_SESSION']}", 'User-Agent' => 'Chris Sturm <casturm@gmail.com>' })

    # Status will be 200 whether or not the answer is correct. We must check the body. The response is in a <main><article> tag.
    body = res.body

    if body.include?("That's not the right answer")
      File.write('./inputs/error.html', body)
      raise 'Incorrect answer'
    end

    raise 'Too soon' if body.include?('You gave an answer too recently')

    return unless body.include?("That's the right answer")

    puts "Correct! Finished Part #{level}"
    File.write("./inputs/day-#{day}-#{level}.txt", answer)
  end

  # Strings
  def lines(string)
    string.split("\n")
  end

  def characters(str_or_arr)
    return str_or_arr.split('') if str_or_arr.is_a? String

    str_or_arr.map { |line| characters(line) }
  end

  def split_arr(arr, index)
    [
      arr[0...index],
      arr[index..]
    ]
  end

  def upper?(letter)
    letter == letter.upcase
  end

  def get_numbers(str)
    proc = proc { |val| val.include?('.') ? val.to_f : val.to_i }

    str.scan(/-?\d+\.\d+|-?\d+/).map(&proc)
  end

  def self.add_number_arrays(arr, arr2)
    arr.map.with_index do |v, i|
      v + arr2[i]
    end
  end
end
