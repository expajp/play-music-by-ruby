# -*- coding: utf-8 -*-
require 'wav-file'

if ARGV.size < 3
  puts 'ruby sample.rb input.wav frequency_of_input output.wav'
  exit 1
end

f = open(ARGV.shift)
format = WavFile::readFormat(f)
chunks = WavFile::readDataChunk(f)
f.close

bit = 's*'
wavs = chunks.data.unpack(bit)

frq_input = ARGV.shift.to_i
block_for_extend = format.hz.to_i/frq_input # 1周期分のデータブロック数
puts "block_for_extend: #{block_for_extend}"

new_wavs = Array.new(wavs.length*2).map.with_index do |data, index| 
  nth_cycle = index/(block_for_extend*2) # 今扱っているデータは第何周期か
  nth_data  = index%block_for_extend # 入れるべきデータはその周期の第何個目か
  wavs[nth_cycle*block_for_extend+nth_data]
end.reject(&:nil?)
puts new_wavs.length

chunks.data = new_wavs.pack(bit)

open(ARGV.shift, "w"){|out|
  WavFile::write(out, format, [chunks])
}
