#!/usr/bin/ruby

if ( ARGV.size != 1 )
  $stderr.puts 'Usage: soundChange.rb [inflectionFile.yaml]'
else 

require 'yaml'

FILE=File.open( ARGV[0]) { |yf| YAML::load( yf ) }

WORD=FILE['word']

def eachWord ( string )
  string.split.each do |s|
    yield s
  end
end

while str = $stdin.gets() do
  eachWord(str) do |w|
    results = ['']
    WORD.each do |part|
      if part == 'root'
        results.each{ |s| s<<w }
      else
        fullres = []
        FILE[part].each do |klass,values|
          medres = []
          values.each do |val|
            newres = []
            results.each { |s| newres << s+val }
            medres += newres
          end
          fullres += medres
        end
        results = fullres
      end
    end
    results.each {|s| puts s}
    puts ''
  end
end

end
