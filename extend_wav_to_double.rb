# -*- coding: utf-8 -*-
require 'wav-file'

if ARGV.size < 2
  puts 'ruby sample.rb input.wav output.wav'
  exit 1
end

f = open(ARGV.shift)
format = WavFile::readFormat(f)
chunks = WavFile::readDataChunk(f)
f.close

bit = 's*'
wavs = chunks.data.unpack(bit)
puts wavs.length

new_wavs = Array.new(wavs.length*2).map.with_index{ |data, index| wavs[index/2] }
puts new_wavs.length

chunks.data = new_wavs.pack(bit)

open(ARGV.shift, "w"){|out|
  WavFile::write(out, format, [chunks])
}
