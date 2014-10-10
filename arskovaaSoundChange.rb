module NoInitialDoubleConsonants
  def self.run( word )
    word.gsub /([mnpbtdkgqcxshrw]|ḡ)(\1)/, '\1'
  end
end

module JIisII
  def self.run( word )
    word.gsub /^ji|ij$/, 'ii'
  end
end

module WUisUU
  def self.run( word )
    word.gsub /^wu|uw$/, 'uu'
  end
end

module RRisRR
  def self.run( word )
    word.gsub /^rŕ|ŕr$/, 'ŕŕ'
  end
end

module WOisO
  def self.run( word )
    word.gsub /^wo|ow$/, 'o'
  end
end

module JEtoE
  def self.run( word )
    word.gsub /^je|ej$/, 'e'
  end
end

module IJRule
  def self.run( word )
    word.gsub! /^ij([mnpbtdkgqcxshrw]|ḡ)/, 'ii\1'
    word.gsub! /([mnpbtdkgqcxshrw]|ḡ)ji$/, '\1ii'
    word
  end
end

module UWWRule
  def self.run( word )
    word.gsub! /^uw([mnpbtdkgqḡcxshrj])/, 'uu\1'
    word.gsub! /([mnpbtdkgqḡcxshrj])wu$/, '\1uu'
    word
  end
end

module RRRRule
  def self.run( word )
    word.gsub! /^ŕr([mnpbtdkgqḡcxshwj])/, 'ŕŕ\1'
    word.gsub! /([mnpbtdkgqḡcxshwj])rŕ$/, '\1ŕŕ'
    word
  end
end

module XYZDelZ
  def self.run( word )
    word.gsub /(.*)(\1)(\1)/, '\1\1'
  end
end

module InterVocalicVoicing
  def self.run( word )
    while m = /([mnrjwvaiyueo]|ň|ä|ï|ö|ü|ë|ÿ|ŕ|ř)([sh]|š|ȟ)([mnrjwvaiyueo]|ň|ä|ï|ö|ü|ë|ÿ|ŕ|ř)/.match(word) do
      word = m.pre_match+m[1]+voiceTheFricative(m[2])+m[3]+m.post_match
    end
    word 
  end
  private 
  def self.voiceTheFricative(fricative)
    {'s' => 'z', 'h' => '', 'š' => 'ž', 'ȟ' => '' }[fricative]
  end
end

module VowelDeletion
  def self.run( word )
    while m = /(^|[ptkqshcx]|š|č|ť|ǩ|ẍ|ȟ)([iyu]|ü|ï|ŕ|ř)([ptkqshcx]|š|č|ť|ǩ|ẍ|ȟ|$)/.match(word) do
      newword = m.pre_match+m[1]+m[3]+m.post_match
      if newword =~ /[aiyueo]|ä|ï|ö|ü|ë|ÿ|ŕ|ř/
        word = newword
      else
        return word
      end
    end
    word
  end
end

module NtoM
  def self.run( word )
    word.gsub /n([bp])/, 'm\1'
  end
end

module MtoN
  def self.run( word )
    word.gsub /m([tdkgq]|ḡ)/, 'n\1'
  end
end

module VowelHarmony
  def self.run( word )
    case /^([mnpbtdkgqcxshrjw]|ḡ|ň|ť|ď|ǩ|ǧ|č|ẍ|ȟ)*([aiyueo]|ä|ï|ö|ü|ë|ÿ|ŕ|ř)/.match( word )[2]
    when 'ŕ'
      word.gsub!( 'i', 'y')
      word.gsub!( 'e', 'ÿ')
    when /[ie]/
      {'ŕ' => 'ř', 'u' => 'ü', 'o' => 'ö', 'a' => 'ä'}.each do |k,v|
        word.gsub!( k, v )
      end
    when /[uoa]/
      word.gsub!( 'i', 'ï' )
      word.gsub!( 'e', 'ë' )
    else
    end
    word
  end
end

module Palatize
  def self.run(word)
    map = {'n' => 'ň', 't' => 'ť', 'd' => 'ď', 'k' => 'ǩ', 'g' => 'ǧ', 'c' => 'č', 'x' => 'ẍ', 's' => 'š', 'h' => 'ȟ'}
    map.each do |k,v|
      word.gsub! "#{k}j",v
      word.gsub! /#{k}([ie]|ř|ü|ö|ä)/, "#{v}\\1"
    end
    word
  end
end

module WtoV
  def self.run(word)
    word.gsub 'w', 'v'
  end
end

module VowelAssim
  def self.run(word)
    word.gsub! /([ayeo]|ä|ï|ö|ü|ë|ÿ|ř)([ayeo]|ä|ï|ö|ü|ë|ÿ|ř)/, '\2\2'
    word.gsub! /i([ayueo]|ä|ï|ö|ü|ë|ÿ|ŕ|ř)/, 'j\1'
    word.gsub! /u([aiyeo]|ä|ï|ö|ü|ë|ÿ|ŕ|ř)/, 'w\1'
    word.gsub! /ŕ([aiyueo]|ä|ï|ö|ü|ë|ÿ|ř)/, 'r\1'
    word.gsub! /([ayeo]|ä|ï|ö|ü|ë|ÿ|ř)i/, '\1j'
    word.gsub! /([ayeo]|ä|ï|ö|ü|ë|ÿ|ř)u/, '\1w'
    word.gsub! /([ayeo]|ä|ï|ö|ü|ë|ÿ|ř)ŕ/, '\1r'
    word
  end
end

module PDeletion
  def self.run(word)
    word.gsub! /^p([mnjrwaiuyo]|ň|ä|ï|ü|e|ë|ÿ|ö|ŕ|ř)/, '\1'
    word.gsub! /([mnjrwaiuyo]|ň|ä|ï|ü|e|ë|ÿ|ö|ŕ|ř)p([mnjrwaiuyo]|ň|ä|ï|ü|e|ë|ÿ|ö|ŕ|ř)/, '\1v\2'
    word.gsub! /([mnjrw]|ň)p$/, '\1'
    word.gsub! /([aiyueo]|ä|ï|ö|ü|ë|ÿ|ŕ|ř)p$/, '\1\1'
    word
  end
end

module GtoQ
  def self.run(word)
    word.gsub /^ḡ/, 'q'
  end
end

module GtoR
  def self.run(word)
    word.gsub /^(.+)ḡ(.+)$/, '\1r\2'
  end
end

RULES = [MtoN, NtoM, JIisII, WUisUU, RRisRR, WOisO, JEtoE, IJRule, UWWRule, RRRRule, XYZDelZ, VowelHarmony, Palatize, VowelDeletion, NoInitialDoubleConsonants, PDeletion, InterVocalicVoicing, VowelAssim, WtoV, GtoQ, GtoR]
