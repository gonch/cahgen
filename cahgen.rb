#!/usr/bin/env ruby

# Turns a list of questions or answers for CaH into PDF pages
# 
# Usage:
# cahgen -q questions.txt
# cahgen -a answers.txt
#
# If no file is supplied, reads questions and answers from STDIN.
# 
# Questions and answers are delimited by newlines. In order to have a multiline
# question or answer, finish the line with a backslash.

# Rubygem includes
require "prawn"
require "trollop"

# Library includes
require "./lib/inputfile"
require "./lib/blank_input"
require "./lib/pdf_file"

opts = Trollop.options do
  opt :black, "Generate black cards"
  opt :white, "Generate white cards"
  opt :blank, "Make a blank sheet"
end

input = if opts[:blank]
  BlankInput.new
elsif ARGV.size > 0
  InputFile.from_file ARGV.shift
else
  InputFile.from_stdin
end

white = if opts[:black]
  false
else
  true
end

output = PDFFile.new(input,white)

output.render!