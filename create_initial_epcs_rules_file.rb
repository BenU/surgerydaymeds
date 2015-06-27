# This script just adds the default, "Take as usual."
# I'll modify the few EPC's with different rules by hand.

text = File.open('epcs.csv').read
epc_a = []
text.each_line do |e| 
  e.chomp!
  epc_a << e << "6,\"Take as usual.\"\n"
end

open('epcs_with_rules.csv', 'w') do |f|
  epc_a.each { |epc| f << epc }
end
