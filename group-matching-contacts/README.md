# Group Matching Contacts

<div>AUTHOR: Scott Knight</div>
<div>LAST UPDATE: 2020/06/26</div>

## The Challenge

Create a Ruby command-line script which reads and parses a CSV file containing customer contact. The script should accept a command to match on matching types, specifically, to match on phone numbers, email, or both. The script should output the results to a text file. How you display the results is up to you. This repo contains the CSV files you should use to scan, parse, and output the results.

<br>

### Notes About the Challenge and the Script

The challenge asked that the script had the ability to accept matching types using the words `email` and `phone` in the command-line when executing the script. I felt it was a cleaner solution to use switches as matching types rather than having scan ARGV for those words.

I added the timing output a couple of days after I submitted my code for review.

<br>

## My Solution

This Ruby script consumes a csv file which contains contact information. The script scans each row for matching contacts, comparing email and/or phone numbers. When the script scans a row, it generates a *matchables* list and searches for matching data against that list. When matching data is found, it scans the new matched row for new matchable data (emails or phone numbers) and updates the matchables list. After the matchables list is updated, the newly matched row is added to an exception (matched) list to avoid rescaning the same row again. When matches are found, the results are appended to a text file, displaying matches grouped together in a table, and each table displaying the matching csv row numbers and the associated data. At the top of the generated text file, a description displays the names of the compared columns. At the bottom of the text file it displays an error if the process crashes at any point, or a success message displaying the total number of rows matched and the total time it took to run the matching process. It also alerts the user if there are no matches found. The status of the matching process is output to the console as well as the final results.

Please read each section for details on how to use this utility. This code was created using Ruby 2.7.1.

<br>

### REQUIREMENTS

* This code requires Ruby 2.6+
* The CSV file must contain a header row and specific column names to match by email and phone. To match by email, the header row must have a column name which contains the word *email*. The column names can vary, i.e. *email*, *email1*, *email2*, *etc*. The same rule applies for *phone*.

<br>

## Running the Code

You should clone the repo as it includes the script and sample CSV files. Review each section below for details on how to use the script.

<br>

### VIEWING HELP CONTENT

To see the list of usable options, use:

```zsh
  $ ruby group_matching_contacts.rb -h
```

It should return the following:

```sh
➜ ruby group_matching_contacts.rb -h
Usage: group_matching_contacts [options]
    -e, --match-email   Match by email
    -p, --match-phone   Match by phone number
    -f PATH_TO_FILE     You must specifiy the path to a csv file using: '-f path_to_file.csv'
```

<br>

### FILE LOCATION

To parse a csv file, you must use the ***-f*** flag and specify a file path. The file is name is checked to ensure you are using a CSV file. The file name must end with ***.csv***, if not, it will display an error.

**Usage Example:**

```zsh
$ ruby group_matching_contacts.rb -f path_to_file.csv
```

<br>

### MATCHING TYPES

To match rows for email and phone, use the followng commandline switches:

* *-e* to match by email
* *-p* to match by phone
* *-ep* or *-pe* to match by both

If none of these switches are used, it will display and error.

<br>

**Example of matching by email:**

```zsh
$ ruby group_matching_contacts.rb -f path_to_file.csv -e
```

<br>

**Example of matching by phone:**

```zsh
$ ruby group_matching_contacts.rb -f path_to_file.csv -p
```

<br>

**Example of matching by both:**

```zsh
$ ruby group_matching_contacts.rb -f path_to_file.csv -ep
```

<br>

### Results

Once the script has finished, it will create a file and notify the user of the name of the created file. For example:

```sh
➜ ruby group_matching_contacts.rb -f input1.csv -e
Checking for email columns...DONE!
Running the match process, please wait...DONE!
Please review matching-contacts-2020-07-28T140538691.txt for grouped matches.
Total matched rows: 2
Total runtime: 0h 0m 0s 1ms
```