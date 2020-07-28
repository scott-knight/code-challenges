require 'optparse'
require 'csv'

=begin
================================================================================
  AUTHOR: Scott Knight
  LAST UPDATE: 2020/06/26

  DESCRIPTION:
    This is a Ruby script which consumes a csv file which contains contact
    information. The script scans each row for matching contacts, comparing
    email and/or phone numbers. When the script scans a row, it generates a
    matchables list and searches for matching data against that list. When
    matching data is found, it scans the new matched row for new matchable data
    (emails or phone numbers) and updates the matchables list. After the
    matchables list is updated, the newly matched row is added to an exception
    (matched) list to avoid rescaning the same row again. When matches are
    found, the results are appended to a text file, displaying matches grouped
    together in a table, and each table displaying the matching csv row numbers
    and the associated data. At the top of the generated text file, a
    description displays the names of the compared columns. At the bottom of the
    text file it displays an error if the process crashes at any point, or a
    success message displaying the total number of rows matched and the total
    time it took to run the matching process. It also alerts the user if there
    are no matches found. The status of the matching process is output to the
    console as well as the final results.

    Please read each section for details on how to use this utility. This code
    was created using Ruby 2.7.1.

  REQUIREMENTS:
  1) This code requires Ruby 2.6+
  2) The CSV file must contain a header row and specific column names for this
     utility to match by email and phone. To match by email, the header row must
     have a column name which contains the word 'email'. The column names can
     vary, i.e. 'email', 'email1', 'email2', etc. The same rule applies
     for 'phone'.

  HELP:
  To see the list of usable options, use:
  $ ruby group_matching.rb -h

  FILE LOCATION:
  To parse a csv file, you must use the '-f' flag and specify a file path.
  The file is name is checked to ensure you are using a CSV file. The file name
  must end with '.csv'; if not, it will display an error.

  Usage Example:
  $ ruby group_matching.rb -f path_to_file.csv

  MATCHING TYPES:
  To match rows for email and phone, use the followng command-line switches:
  -e to match by email
  -p to match by phone
  -ep or -pe to match by both

  If none of these switches are used, it will display and error.

  Example of matching by email:
  $ ruby group_matching.rb -f path_to_file.csv -e

  Example of matching by phone:
  $ ruby group_matching.rb -f path_to_file.csv -p

  Example of matching by both:
  $ ruby group_matching.rb -f path_to_file.csv -ep
================================================================================
=end

## Constants -----
BASE_ROW_SIZE = 7
BASE_COLUMN_SIZE = 25


## Methods -----
def append_file(file_name, text)
  File.open(file_name, 'a') { |f| f.write(text) }
end

def append_matched_rows(file_name, matched_rows)
  row_size     = txt_row_size(matched_rows)
  content_size = txt_content_size(matched_rows)
  header       = txt_header(row_size, content_size)
  separator    = txt_separator(row_size, content_size)
  rows         = txt_rows(row_size, matched_rows)
  append_file(file_name, "\n\n\n#{header}\n#{separator}\n#{rows}")
end

def collect_matching_rows(matchables, csv, matchable_indexes = [])
  return [] if matchables.empty? || matchable_indexes.empty?

  rows    = []
  matched = []
  stop    = false

  until stop
    results = csv.each_with_index.map do |row, csvi|
      next if matched.include?(csvi)

      [csvi, row[0]] if row[1].any? { |value| matchables.include?(value) }
    end.compact

    unless results.empty?
      results.each do |r|
        matched |= [r[0]]
        rows    |= [r[1]]
      end
      matchable_indexes.each do |mi|
        matchables |= results.map { |r| csv[r[0]].dig(1, mi) }.compact
      end
    end
    stop = results.empty?
  end

  rows
end

def create_file_and_add_title(file_name, column_names)
  text = "Processed the csv file '#{@options[:file]}', matching on " \
    "#{txt_column_names(column_names)}. Matching rows are grouped together."
  File.write(file_name, text)
end

def csv_array_of_hashes(phone_indexes = [])
  return [] unless @options[:file]

  CSV.foreach(@options[:file]).with_index.map do |r,i|
    next if i.zero?

    phone_indexes.each { |pi| r[pi] = sanitize_phone_number(r[pi]) } unless phone_indexes.empty?
    [ i + 1, r ]
  end.compact
end

def header_error_message(name)
  " #{name.capitalize} column was not found in the header row. " \
    "Unable to match by #{name.downcase}"
end

def no_matches(file_name)
  text = "No matches were found."
  puts text
  append_file(file_name, "\n\n\n#{text}")
end

def refine_matched_rows(csv, rows)
  results = rows.map { |r| csv.find { |c| c[0] == r } }
  results.map { |row| [row[0], row[1] .join(',')] }
end

def sanitize_phone_number(number)
  return number if number.nil?

  number.to_s.delete('^0-9').chars.last(10).join
end

def time_tag
  (Time.now.to_f * 1000.0).to_i
end

def total_matched(file_name, matched)
  return no_matches(file_name) if matched.zero?

  message = "Total matched rows: #{matched}"
  puts "Please review #{file_name} for grouped matches."
  puts message
  append_file(file_name, "\n\n\nMatching complete!\n#{message}")
end

def total_runtime(file_name, start_time)
  total_time     = time_tag - start_time
  hours          = (total_time / ( 1000 * 60 * 60 )) % 24
  minutes        = (total_time / ( 1000 * 60 ) ) % 60
  seconds        = (total_time / 1000 ) % 60
  milliseconds   = (total_time % 1000)
  message        = "Total runtime: #{hours}h #{minutes}m #{seconds}s #{milliseconds}ms"

  puts message
  append_file(file_name, "\n#{message}")
end

def txt_column_names(column_names)
  "#{column_names.join(' and ')} column#{column_names.size > 1 ? 's' : ''}"
end

def txt_content_size(matched_rows)
  content_size = matched_rows.map { |mr| mr[1].to_s.length }.max
  content_size > BASE_COLUMN_SIZE ? content_size : BASE_COLUMN_SIZE
end

def txt_header(row_size, content_size)
  [ '  ',
    ['CSV ROW', Array.new(row_size - BASE_ROW_SIZE) { ' ' }.join].join,
    '   ',
    ['ROW CONTENT', Array.new(content_size - BASE_COLUMN_SIZE) { ' ' }.join].join,
    '  '
  ].join
end

def txt_row_size(matched_rows)
  row_size = matched_rows.map { |mr| mr[0].to_s.length }.max
  row_size > BASE_ROW_SIZE ? row_size : BASE_ROW_SIZE
end

def txt_rows(row_size, matched_rows)
  matched_rows.map do |mr|
    [ '  ',
      mr[0].to_s,
      Array.new(row_size - mr[0].to_s.length) { ' ' }.join,
      '   ',
      mr[1].to_s
    ].join
  end.join("\n")
end

def txt_separator(row_size, content_size)
  [ '+-',
    Array.new(row_size) { '-' }.join,
    '-+-',
    Array.new(content_size) { '-' }.join,
    "-+"
  ].join
end


## Create the switches, the file flag, and validate the options -----
errors        = []
@options      = {}
file_message  = "You must specifiy the path to a csv file using: '-f path_to_file.csv'"
option_parser = OptionParser.new do |opts|
  opts.on('-e', '--match-email', 'Match by email') do
    @options[:match_email] = true
  end

  opts.on('-p', '--match-phone', 'Match by phone number') do
    @options[:match_phone] = true
  end

  opts.on('-f PATH_TO_FILE', file_message) do |file|
    errors << file_message unless file =~ /\w+\.csv/
    @options[:file] = file if errors.empty?
  end
end
option_parser.parse!

# Validate options
if !@options[:match_email] && !@options[:match_phone]
  errors << 'You must specifiy to match by email [-e], phone [-p], or email and phone [-ep]'
end

errors |= [file_message] unless @options[:file]

unless errors.empty?
  puts 'Errors:'
  errors.each_with_index { |e,i| puts "#{i+1}. #{e}" }
  exit 1
end


## Collect and validate header indexes -----
email_indexes    = []
phone_indexes    = []
column_names     = []
required_columns = []
header_row       = CSV.read(@options[:file])[0].each { |i| i.downcase! }

# Get email columns
if @options[:match_email]
  required_columns << 'email'
  print "Checking for email columns..."
  header_row.each_with_index do |h,i|
    if h =~ /\w*email\w*/
      email_indexes << i
      column_names  << h
    end
  end
  puts 'DONE!' unless email_indexes.empty?
  puts header_error_message('email') if email_indexes.empty?
end

# Get phone columns
if @options[:match_phone]
  required_columns << 'phone'
  print "Checking for phone columns..."
  header_row.each_with_index do |h,i|
    if h =~ /\w*phone\w*/
      phone_indexes << i
      column_names  << h
    end
  end
  puts 'DONE!' unless phone_indexes.empty?
  puts header_error_message('phone') if phone_indexes.empty?
end

checkable_indexes = (email_indexes + phone_indexes).sort

# Validate the indexes
if checkable_indexes.empty?
  puts "Unable to proceed without the #{txt_column_names(required_columns)} " \
    "in the header row."
  exit 2
end


## Do the Work -----
start_time = time_tag
begin
  print "Running the match process, please wait..."
  matched = 0
  csv1    = csv_array_of_hashes
  csv2    = csv_array_of_hashes(phone_indexes)
  csv3    = csv2.clone

  file_name = "matching-contacts-#{Time.new.strftime('%Y-%m-%dT%H%M%S%L')}.txt"
  create_file_and_add_title(file_name, column_names)

  csv2.each_with_index do |cvs_row, idx|
    next unless csv3.find { |ch2| ch2[0] == idx + 2 }

    emails     = email_indexes.map { |ei| cvs_row.dig(1, ei) }.compact
    phones     = phone_indexes.map { |pi| cvs_row.dig(1, pi) }.compact
    matchables = (emails + phones).uniq

    rows = collect_matching_rows(matchables, csv3, checkable_indexes).sort

    if rows.size > 1
      matched_rows = refine_matched_rows(csv1, rows)
      matched += matched_rows.size
      append_matched_rows(file_name, matched_rows)
    end

    rows.each do |row_num|
      csv3.delete_at(csv3.index(csv3.find { |r| r[0] == row_num }))
    end
  end

  puts 'DONE!'
rescue StandardError => e
  message = "Error: #{e.message}"
  puts message
  append_file(file_name, "\n\nAn error occured while processing the csv. #{message}")
end

total_matched(file_name, matched)
total_runtime(file_name, start_time)