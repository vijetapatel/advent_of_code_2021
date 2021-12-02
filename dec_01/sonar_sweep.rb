class SonarSweep
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
    data = get_file_data(filename: filename).map(&:to_i)

    counter = 0
    (0..(data.length-2)).each do |i|
      num1 = data[i]
      num2 = data[i+1]

      if num2 > num1
        counter += 1
      end
    end
    counter
  end

  def do_part_two(filename:)
    data = get_file_data(filename: filename).map(&:to_i)

    counter = 0
    (0..(data.length-4)).each do |i|
      num1 = data[i] + data[i+1] + data[i+2]
      num2 = data[i+1] + data[i+2] + data[i+3]

      if num2 > num1
        counter +=1
      end
    end
    counter
  end
end
