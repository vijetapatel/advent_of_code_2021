
load '../common/common.rb'
load 'sonar_sweep.rb'

include Common

# https://adventofcode.com/2021/day/1
problem_klass = SonarSweep

# part_one_test_run(klass: problem_klass) # 7
# part_one(klass: problem_klass) # 1482

# part_two_test_run(klass: problem_klass) # 5
part_two(klass: problem_klass) # 1518
