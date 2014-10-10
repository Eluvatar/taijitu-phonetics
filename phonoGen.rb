#!/usr/bin/ruby

require 'yaml'

if ( ARGV.size != 2 )
  $stderr.puts 'Usage: nameGen.rb [langfile] [# of syllables]'
else 
$stderr.puts "making #{ARGV[1]} syllables"

FILE=File.open( ARGV[0]) { |yf| YAML::load( yf ) }

SYLLABLE=FILE['syllable']

def get(t,r)
  FILE[t].each do |k,v|
    if ( r<v )
      return k
    else
      r-=v
    end
  end
  ''
end

ARGV[1].to_i.times do
  SYLLABLE.each do |r|
    print get(r,rand)
  end
end
puts ''

end
