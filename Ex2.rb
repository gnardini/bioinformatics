#!/usr/bin/env ruby
require 'bio'

blast = Bio::Blast.remote('blastp', 'swissprot', '-e 0.0001', 'genomenet')
# blast = Bio::Blast.local('blastn', 'swissprot')

ff = Bio::FlatFile.open(Bio::FastaFormat, 'itih4-aa.fas')

File.open('blast.out', 'w') do |f|
  ff.each_entry do |entry|
    report = blast.query(entry.seq)
    report.each do |hit|
      f.puts('------------------------------------------------')
      f.puts "Score: #{hit.bit_score}"
      f.puts 'Target ID: ' + hit.target_id
      f.puts 'Definition: ' + hit.target_def
      f.puts 'Sequence length: ' + hit.target_len.to_s
      f.puts 'Sequence: ' + hit.target_seq
      f.puts "Number of identities: #{hit.identity}"
      f.puts "Overlap: #{hit.overlap}"
      f.puts "Query start: #{hit.query_start} end: #{hit.query_end}"
      f.puts "Target start: #{hit.target_start} end: #{hit.target_end}"
    end
  end
end
