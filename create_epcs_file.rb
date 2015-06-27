text = File.open('drug_classes_unique.csv').read
epcs = []
text.each_line do |line| 
  line.split(",").each do |n|
    if n.include? "EPC"
      n.slice!("[EPC]")
      n.slice!('"')
      n = n.strip.downcase
      epcs << "\"#{n}\"," unless epcs.include?("\"#{n}\",")
    end
  end
end

open('epcs.csv', 'w') do |f|
  epcs.sort.each { |epc| f << epc << "\n"}
end
