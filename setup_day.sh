#!/bin/bash

# Ask for the day
read -p 'Challenge Day: ' day

# Pad the day with a leading 0 so that the folder is nicely ordered
day=$(printf %02d "$((10#$day))" );

echo Initialising solution and test folder for day $day

# Copy the two directories and rename to contain the day
cp -R ./lib/day_00 ./lib/day_$day
cp -R ./test/day_00 ./test/day_$day

# Copy the example input file and rename
cp ./test/day_$day/example_input_01.txt ./test/day_$day/input.txt

# Then we'll replace 00 in the source and test files with the day number
sed -i '' "s/00/$day/g" ./lib/day_$day/task_01.rb
sed -i '' "s/00/$day/g" ./lib/day_$day/task_02.rb
sed -i '' "s/00/$day/g" ./test/day_$day/test_task_01.rb
sed -i '' "s/00/$day/g" ./test/day_$day/test_task_02.rb