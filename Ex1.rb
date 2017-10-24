#!/usr/bin/env ruby
require 'bio'

entries = Bio::GenBank.open('itih4.gb')

File.open('itih4-aa.fas', 'w') do |f|
  entries.each_entry do |entry|
    seq = entry.to_biosequence
    f.write(seq.translate(3).to_fasta) unless seq.empty?
  end
end
