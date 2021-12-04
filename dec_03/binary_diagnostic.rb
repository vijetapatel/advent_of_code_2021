class BinaryDiagnostic
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

    num_bits = data.first.length

    zeros_counters = Array.new(num_bits, 0)
    data.each do |datum|
      index_counter = 0
      bits = datum.split("")
      bits.each do |bit|
        if bit == "0"
          zeros_counters[index_counter] += 1
        end
        index_counter += 1
      end
    end
    # log "zeros_counters: #{zeros_counters}"

    gamma_rate = ""
    zeros_counters.each do |zeros_count|
      ones_count = data.length - zeros_count
      if zeros_count > ones_count
        gamma_rate += "0"
      else
        gamma_rate += "1"
      end
    end

    # log "gamma_rate binary: #{gamma_rate}"
    gamma_rate_integer = gamma_rate.to_i(base=2)
    epsilon_rate_integer = gamma_rate.to_i(base=2) ^ ("1" * num_bits).to_i(base=2)
    # log "gamma_rate_integer: #{gamma_rate_integer}"
    # log "epsilon_rate_integer: #{epsilon_rate_integer}"
    gamma_rate_integer * epsilon_rate_integer
  end

  def do_part_two(filename:)
    data = get_file_data(filename: filename)

    o2_data = remaining_data(data.clone, true)
    co2_data = remaining_data(data.clone, false)

    # log "Remaining o2 number: #{o2_data[0].to_i(base=2)}"
    # log "Remaining co2 number: #{co2_data[0].to_i(base=2)}"

    o2_data[0].to_i(base=2) * co2_data[0].to_i(base=2)
  end

  def remaining_data(data, use_most_common)
    index = 0
    while data.count > 1
      num_zeros = count_zeros(data, index)
      num_ones = data.length - num_zeros

      #log "index: #{index}, num_zeros: #{num_zeros}, num_ones: #{num_ones}"

      if use_most_common
        data = filter_data_with_most_common_value(data, num_zeros, num_ones, index)
      else
        data = filter_data_with_least_common_value(data, num_zeros, num_ones, index)
      end

      #log "data: #{data}"
      index += 1
    end
    data
  end

  def filter_data_with_most_common_value(data, num_zeros, num_ones, index)
    if num_zeros > num_ones
      data = filter_data(data, index, "0")
    else
      data = filter_data(data, index, "1")
    end
  end

  def filter_data_with_least_common_value(data, num_zeros, num_ones, index)
    if num_zeros > num_ones
      data = filter_data(data, index, "1")
    else
      data = filter_data(data, index, "0")
    end
  end

  def count_zeros(data, index)
    data.count { |datum| datum[index] == "0" }
  end

  def filter_data(data, index, bit)
    data.select { |datum| datum[index] == bit }
  end
end
