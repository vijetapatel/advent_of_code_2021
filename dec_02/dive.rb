class Dive
  include Common

  def initialize
  end

  def part_one_test_run
    do_part_one(filename: "sample_input.txt")
  end

  def part_one
    do_part_one(filename: "input.txt")
  end

  def part_two_test_run
    do_part_two(filename: "sample_input.txt")
  end

  def part_two
    do_part_two(filename: "input.txt")
  end

  def do_part_one(filename:)
    data = get_file_data(filename: filename)

    horizontal_position = 0
    depth = 0
    (0..(data.length-1)).each do |i|
      command, units = data[i].split(" ")
      units = units.to_i

      case command
      when "forward"
        horizontal_position += units
      when "down"
        depth += units
      when "up"
        depth -= units
      else
        log "Unknown command"
      end
    end
    log "Horizontal position: #{horizontal_position}, Depth: #{depth}, Product: #{horizontal_position*depth}"
    horizontal_position*depth
  end

  def do_part_two(filename:)
    data = get_file_data(filename: filename)

    horizontal_position = 0
    depth = 0
    aim = 0

    (0..(data.length-1)).each do |i|
      command, units = data[i].split(" ")
      units = units.to_i

      case command
      when "forward"
        horizontal_position += units
        depth += (aim * units)
      when "down"
        aim += units
      when "up"
        aim -= units
      else
        log "Unknown command"
      end
    end
    log "Horizontal position: #{horizontal_position}, Depth: #{depth}, Product: #{horizontal_position*depth}"
    horizontal_position*depth
  end
end
