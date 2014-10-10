#!/usr/bin/ruby

if ( ARGV.size != 1 )
  $stderr.puts 'Usage: soundChange.rb [soundchangesfile]'
else 

require ARGV[0]

def eachWord ( string )
  string.split.each do |s|
    yield s
  end
end

while str = $stdin.gets() do
  eachWord(str) do |w|
    RULES.each do |rule| 
      w=rule.run(w)
    end
    print w
    puts ''
  end
end

end
