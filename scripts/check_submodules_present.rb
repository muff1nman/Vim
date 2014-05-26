#!/usr/bin/env ruby

submodules = `git submodule status --recursive`.lines.map(&:chomp)

submodules.each do |submodule|
  if submodule =~ /^-/
    abort "Submodule#{submodule} has not been cloned"
  end
end

#submodules = `git submodule foreach -q --recursive 'echo $(pwd)'`.lines.map(&:chomp)

#submodules.each do |submodule|
  #puts "#{submodule} has #{Dir.entries(submodule).size}"
	#if Dir.entries(submodule).size < 3
	#end
#end
