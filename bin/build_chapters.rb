#!/usr/bin/env ruby

# bin/build_chapters.rb [-t <TITLE>]

# Assumes chapters/01_01_title.txt format.
# That is, several sub-chapters per chapter
# Writes total/Chapter_01 as an accumulation of sub-chapters.
# If TITLE given writes book/<TITLE>, otherwise 
# TITLE is 'Book'.

require 'fileutils'
require 'optparse'

chapter_dir = 'chapters'
total_dir   = 'total'
book_dir    = 'book'

options = Hash.new(0)
option_parser = OptionParser.new do |opts|
  opts.on('-t', '--title TITLE', 'Title of the book') do |t|
    options[:title] = t
  end
end
option_parser.parse!

if options[:title] == 0
  book_name = 'Book'
else
  book_name = options[:title]
end
puts("book name is #{book_name}.")

if File.directory?(total_dir)
  FileUtils.rm_rf(total_dir)
end
Dir.mkdir(total_dir)

if File.directory?(book_dir)
  FileUtils.rm_rf(book_dir)
end
Dir.mkdir(book_dir)

if File.directory?(chapter_dir)
  chapter_files = Dir.entries(chapter_dir)
  chapter_files.sort!
else
  puts("Need chapters.")
  exit
end

chapter_files.each do |chapter_file|
  if chapter_file.end_with?('.txt')
    chapter = File.read("#{chapter_dir}/#{chapter_file}")
    chapter_count = chapter_file[0..1]
    File.open("#{total_dir}/Chapter_#{chapter_count}", "a") do |file|
      file.write(chapter)
    end
    File.open("#{book_dir}/#{book_name}", "a+") do |file|
      file.write(chapter)
    end
  end
end
