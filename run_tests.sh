#!/bin/bash

# Check whether exactly two command-line arguments were provided.
if [ "$#" -ne 2 ]; then
    # Display the correct way to run the script.
    echo "Usage: $0 <program> <test_file>"

    # End the script with an error status.
    exit 1
fi

# Store the first command-line argument as the program name.
program="$1"

# Store the second command-line argument as the test filename.
test_file="$2"

# Check whether the program exists and is executable.
if [ ! -x "$program" ]; then
    # Display an error message if the program cannot be executed.
    echo "Error: $program does not exist or is not executable."

    # End the script with an error status.
    exit 1
fi

# Check whether the test file exists and is a regular file.
if [ ! -f "$test_file" ]; then
    # Display an error message if the test file does not exist.
    echo "Error: $test_file does not exist."

    # End the script with an error status.
    exit 1
fi

# Initialize the test number to zero.
test_number=0

# Initialize the number of passed tests to zero.
passed=0

# Initialize the number of failed tests to zero.
failed=0

# Remove comment and blank lines, count the remaining lines with awk,
# and store the number in total_tests.
total_tests=$(grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$test_file" | awk 'END {print NR}')

# Read the test file after removing comment lines and blank lines.
grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$test_file" |

# Read one test case at a time and store it in the variable line.
while read -r line; do

    # Use awk to get everything before the | symbol.
    # Use sed to remove spaces from the beginning and end.
    argument=$(echo "$line" | awk -F '|' '{print $1}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Use awk to get everything after the | symbol.
    # Use sed to remove spaces from the beginning and end.
    expected=$(echo "$line" | awk -F '|' '{print $2}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Run the program with the argument and store its output.
    actual=$("$program" "$argument")

    # Increment the test number for this test case.
    test_number=$((test_number + 1))

    # Compare actual output with expected output and report the result.
    if [ "$actual" == "$expected" ]; then
        echo "Test $test_number: PASS"
        passed=$((passed + 1))
    else
        echo "Test $test_number: FAIL"
        echo "  Expected: $expected"
        echo "  Got: $actual"
        failed=$((failed + 1))
    fi

    # The while loop runs in a subshell (because of the pipe), so the counters
    # are lost after "done". Print the summary after the last test instead.
    if [ "$test_number" -eq "$total_tests" ]; then
        echo -e "\n\nPassed: $passed"
        echo "Failed: $failed"
        echo "Total: $total_tests"
    fi

# End the while loop.
done
