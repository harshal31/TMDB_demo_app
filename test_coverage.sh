#!/bin/bash

# Flutter test coverage will not included untested files:
# workaround for this issue is in any of the test file we need to import untested file.
# https://github.com/flutter/flutter/issues/27997
#if ! flutter pub global run melos run test_coverage; then

if ! flutter test --coverage; then
  echo "tests failed"
  exit 1
fi

echo "executing coverage"

search_directory="."
merged_file="lcov_merged.info"
filter_file="filter_lcov.info"
html_dir="coverage_report"

# Remove existing merged file if it exists
[ -f "$merged_file" ] && rm "$merged_file"

# Create an array of all lcov.info files
# shellcheck disable=SC2207
lcov_files=($(find "$search_directory" -type f -name "lcov.info"))

# Process each lcov.info file
for lcov_file in "${lcov_files[@]}"; do
  echo "Processing: $lcov_file"

  # Temporary file for this lcov processed content
  temp_file=$(mktemp)

  # Current directory of the lcov file
  lcov_directory=$(dirname "$lcov_file")

  # Iterate over the lcov file without using stdin
  while IFS= read -r line; do
    if [[ $line == SF:lib/* ]]; then
      dart_file_rel_path=$(echo "$line" | cut -d':' -f2)
      full_dart_file_path=$(find "$lcov_directory/.." -type f -path "*/$dart_file_rel_path" | head -n 1)
      abs_dart_file_path=$(realpath "$full_dart_file_path")
      echo "SF:$abs_dart_file_path" >>"$temp_file"
    else
      echo "$line" >>"$temp_file"
    fi
  done <"$lcov_file"

  # Append temp_file to merged_file
  cat "$temp_file" >>"$merged_file"
  rm "$temp_file"
done

echo "All lcov files merged into $merged_file"

lcov --remove $merged_file '*g.dart' '*api_service*' '*provider*' '*_state.dart' '*gen.dart' 'app_localizations' '*_option*' '*_constant*' '*_endpoint*' '*color*' '*param*' -o $filter_file
# Generate the HTML report and capture the output
output=$(genhtml "$filter_file" -o "$html_dir" 2>&1)
echo "$output"
echo "HTML report generated at project root level with directory name = $html_dir"

# Extract the overall coverage percentage from the console output
coverage=$(echo "$output" | awk -F'[:%]' '/lines......:/ { print int($2) }')

echo "Overall code coverage: $coverage%"

echo "Removing all the directories with exact name coverage"
find . -type d -name coverage -exec rm -r {} +

exit 0
