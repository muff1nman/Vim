#! /usr/bin/env ruby
#
# Copyright © 2014 Andrew DeMaria (muff1nman) <ademaria@mines.edu>
#
# All Rights Reserved.

require 'pathname'
require 'uri'
require 'optparse'

GIT_ENDING = ".git"

def base_name name
  uri = URI.parse(name)
  base = File.basename(uri.path)
  base = base[0..-(GIT_ENDING.length+1)] if base.end_with? GIT_ENDING
  raise "Invalid name" if base.nil? or base.empty?
  base
end

def process_submodules dir, callbacks={}
  Dir.chdir dir do
    top_dir = Pathname.new(Dir.pwd)

    submodules = `git submodule foreach --quiet 'pwd'`.lines.map do |line|
      Pathname.new(line).relative_path_from(top_dir).to_s.chomp
    end

    callbacks[:before].call submodules, dir unless callbacks[:before].nil?
    submodules.each do |submodule|
      callbacks[:during].call submodule unless callbacks[:during].nil?
      process_submodules submodule, callbacks
    end
    callbacks[:after].call submodules, dir unless callbacks[:after].nil?
  end
end

def print_pushd submodules, dir
  puts "pushd #{dir}" unless submodules.empty?
end

def print_popd submodules, dir
  puts "popd" unless submodules.empty?
end

def print_for_submodule submodule
  #puts "Processing submodule [#{submodule}]"
  puts "git submodule init #{submodule}"
  previous_url = `git config submodule.#{submodule}.url`
  #puts "previous url: #{previous_url}"
  puts "git config submodule.#{submodule}.url \"$srcdir/#{base_name previous_url}\""
  puts "git submodule update #{submodule}"
end

def print_url submodule
  puts `git config submodule.#{submodule}.url`
end

USAGE = "Usage: ./path_to_script [--change-remotes | --list-remotes]"
options = {}
OptionParser.new do |opts|
  opts.banner = USAGE

  opts.on("-c", "--change-remotes", "Print the commands required for a makepkg to setup the urls correctly") do |_|
    abort("Only choose one task please") unless options[:action].nil?
    options[:callbacks] = {
      before: method(:print_pushd),
      after: method(:print_popd),
      during: method(:print_for_submodule)
    }
  end

  opts.on("-l", "--list-remotes", "Print a listing of remotes for a makepkg") do |_|
    abort("Only choose one task please") unless options[:action].nil?
    options[:callbacks] = {
      during: method(:print_url)
    }
  end
end.parse!

abort(USAGE) unless options[:callbacks]

process_submodules Dir.pwd, options[:callbacks]
