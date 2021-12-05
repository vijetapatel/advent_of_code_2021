class GiantSquid
  include Common

  class Board
    def initialize
      @board = []
    end

    def self.get_board_data(data)
      board_data = []
      while board_data.length <= 4
        if data[0].chomp == ""
          data.shift
        else
          board_data << data.shift
        end
      end
      board_data
    end

    def build_board(board_data)
      board_data.each do |datum|
        row_array = []
        datum.scan(/\d+/) do |match|
          row_array << {:number => match.to_i, :marked => false}
        end
        @board << row_array
      end
      #log_with_name "@board", @board
    end

    def apply_lottery_number(lottery_number)
      @board.each do |row_array|
        row_array.select { |item| item[:number] == lottery_number}.each { |item| item[:marked] = true}
      end
    end

    def won?
      # Check rows
      @board.each do |row_array|
        if row_array.all? { |item| item[:marked] == true }
          return true
        end
      end

      # Check columns
      @board.first.each_with_index do |num, index|
        if @board.all? { |row| row[index][:marked] == true }
          return true
        end
      end
      return false
    end

    def lost?
      !won?
    end

    def sum_unmarked_numbers
      sum = 0
      @board.each do |row_array|
        sum += row_array.select { |item| item[:marked] == false }.map { |item| item[:number] }.sum
      end
      # log_with_name "sum", sum
      sum
    end

    def print_board
      @board.each do |row_array|
        row_array.each do |item|
          if item[:marked] == true
            lognnl "%02d* " % item[:number]
          else
            lognnl "%03d " % item[:number]
          end
        end
        log ""
      end
      log ""
    end
  end # end Board

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

    lottery_numbers = parse_lottery_numbers(data.shift)
    # log_with_name("lottery_numbers", lottery_numbers)

    boards = build_boards(data)
    # print_boards(nil, nil, boards)

    current_lottery_number = nil
    winning_boards = nil
    lottery_numbers.each_with_index do |lottery_number, index|
      current_lottery_number = lottery_number
      apply_lottery_number_to_boards(boards, lottery_number)
      # print_boards(index, lottery_number, boards)
      winning_boards = find_winning_boards(boards)
      # log_with_name "winning_boards_count", winning_boards.length
      break if winning_boards.any?
    end

    if winning_boards.length > 1
      log "ERROR: More than one winning boards"
    end

    winning_boards.first.sum_unmarked_numbers * current_lottery_number
  end

  def do_part_two(filename:)
    data = get_file_data(filename: filename)

    lottery_numbers = parse_lottery_numbers(data.shift)
    # log_with_name("lottery_numbers", lottery_numbers)

    boards = build_boards(data)
    # print_boards(nil, nil, boards)

    current_lottery_number = nil
    losing_boards = nil
    new_losing_boards = []
    lottery_numbers.each_with_index do |lottery_number, index|
      if new_losing_boards.length == 1
        losing_boards = new_losing_boards.clone
      end

      current_lottery_number = lottery_number
      apply_lottery_number_to_boards(boards, lottery_number)
      new_losing_boards = find_losing_boards(boards)
      break if new_losing_boards.length == 0
      # print_boards(index, lottery_number, boards)
    end

    if losing_boards.length > 1
      log "ERROR: More than one winning boards"
    end

    losing_boards.first.sum_unmarked_numbers * current_lottery_number
  end

  def parse_lottery_numbers(lottery_str)
    lottery_numbers = lottery_str.split(",").map(&:to_i)
  end

  def build_boards(data)
    boards = []
    while !data.empty?
      board_data = Board.get_board_data(data)
      board = Board.new
      board.build_board(board_data)
      boards << board
    end
    boards
  end

  def print_boards(index, lottery_number, boards)
    log "Current board state after turn number #{index}, lottery_number: #{lottery_number}"
    boards.each do |board|
      board.print_board
    end
  end

  def apply_lottery_number_to_boards(boards, lottery_number)
    boards.each do |board|
      board.apply_lottery_number(lottery_number)
    end
  end

  def find_winning_boards(boards)
    boards.select { |board| board.won? }
  end

  def find_losing_boards(boards)
    boards.select { |board| board.lost? }
  end

end
