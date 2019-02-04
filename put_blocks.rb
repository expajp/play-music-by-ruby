# -*- coding: utf-8 -*-
require 'wav-file'

if ARGV.size < 1
  puts 'ruby put_blocks.rb input.wav'
  exit 1
end

f = open(ARGV.shift)
format = WavFile::readFormat(f)
chunks = WavFile::readDataChunk(f)
f.close

bit = 's*' # 16 bit PCM
puts chunks.data.unpack(bit).length
