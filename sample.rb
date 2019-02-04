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

# format.hz *= 2
format.bytePerSec *= 2

bit = 's*' # 16 bit PCM
wavs = chunks.data.unpack(bit)
extended_wavs = Array.new(wavs.length*2)
extended_wavs.map!.with_index{ |n, i| wavs[i/2] }
chunks.data = extended_wavs.pack(bit)

open(ARGV.shift, "w"){|out|
  WavFile::write(out, format, [chunks])
}
