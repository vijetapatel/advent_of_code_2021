
module Common

  def log(msg)
    puts msg
  end

  def lognnl(msg)
    print msg
    STDOUT.flush
  end

  def display(answer)
    log "The answer is: #{answer}"
  end

  def part_one_test_run(klass:)
    log "Part one test run"
    display(klass.new.part_one_test_run)
  end

  def part_one(klass:)
    log "Part one"
    display(klass.new.part_one)
  end

  def part_two_test_run(klass:)
    log "Part two test run"
    display(klass.new.part_two_test_run)
  end

  def part_two(klass:)
    log "Part two"
    display(klass.new.part_two)
  end

  def get_file_data(filename:)
    file = File.open(filename)
    data = file.readlines.map(&:chomp)
    file.close
    data
  end
end
