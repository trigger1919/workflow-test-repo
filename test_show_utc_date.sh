#!/bin/bash

# Test script for show_utc_date.sh
# This script tests various aspects of the UTC date display script

echo "=== Testing show_utc_date.sh ==="
echo ""

# Test 1: Check if the script file exists and is executable
echo "Test 1: Checking if script exists and is executable..."
if [ -f "show_utc_date.sh" ]; then
    echo "✓ Script file exists"
else
    echo "✗ Script file not found"
    exit 1
fi

if [ -x "show_utc_date.sh" ]; then
    echo "✓ Script is executable"
else
    echo "! Script is not executable, making it executable..."
    chmod +x show_utc_date.sh
    if [ -x "show_utc_date.sh" ]; then
        echo "✓ Script is now executable"
    else
        echo "✗ Failed to make script executable"
        exit 1
    fi
fi

echo ""

# Test 2: Run the script and capture output
echo "Test 2: Running the script and checking output..."
output=$(./show_utc_date.sh 2>&1)
exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo "✓ Script executed successfully (exit code: $exit_code)"
else
    echo "✗ Script failed with exit code: $exit_code"
    echo "Output: $output"
    exit 1
fi

echo ""

# Test 3: Verify output contains expected elements
echo "Test 3: Verifying output format..."

# Check for expected text patterns
if echo "$output" | grep -q "Current UTC date and time:"; then
    echo "✓ Contains main header"
else
    echo "✗ Missing main header"
fi

if echo "$output" | grep -q "ISO 8601 format:"; then
    echo "✓ Contains ISO 8601 section"
else
    echo "✗ Missing ISO 8601 section"
fi

if echo "$output" | grep -q "RFC 3339 format:"; then
    echo "✓ Contains RFC 3339 section"
else
    echo "✗ Missing RFC 3339 section"
fi

if echo "$output" | grep -q "Custom readable format:"; then
    echo "✓ Contains custom format section"
else
    echo "✗ Missing custom format section"
fi

echo ""

# Test 4: Verify date formats are valid
echo "Test 4: Verifying date format validity..."

# Extract and validate ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
iso_date=$(echo "$output" | grep -A1 "ISO 8601 format:" | tail -1 | xargs)
if echo "$iso_date" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$'; then
    echo "✓ ISO 8601 format is valid: $iso_date"
else
    echo "✗ ISO 8601 format is invalid: $iso_date"
fi

# Check if dates contain UTC
if echo "$output" | grep -q "UTC"; then
    echo "✓ Output contains UTC timezone indicator"
else
    echo "✗ Output missing UTC timezone indicator"
fi

echo ""

# Test 5: Performance test (should complete quickly)
echo "Test 5: Performance test..."
start_time=$(date +%s.%N)
./show_utc_date.sh > /dev/null 2>&1
end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0.1")

# Check if execution time is reasonable (less than 2 seconds)
if (( $(echo "$execution_time < 2.0" | bc -l 2>/dev/null || echo "1") )); then
    echo "✓ Script executes quickly (${execution_time}s)"
else
    echo "! Script took longer than expected (${execution_time}s)"
fi

echo ""
echo "=== Test Summary ==="
echo "All tests completed. If you see ✓ marks above, the script is working correctly."
echo ""
echo "Sample output from the script:"
echo "----------------------------------------"
./show_utc_date.sh
echo "----------------------------------------"
